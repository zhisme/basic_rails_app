RSpec.describe RunLater do
  describe '#run_later' do
    # Hash is one of types serializable by AJ
    let(:klass) { Class.new(Hash).tap { |x| x.extend described_class } }
    let(:instance) { klass.new(key: :val) }
    let(:args) { [1, 'string'] }

    shared_examples 'for every method kind' do |methods_owner_proc|
      {
        test_method: :test_method_later,
        test_method!: :test_method_later!,
        test_method?: :test_method_later?,
      }.each do |method, later_method|
        context "for method `#{method}`" do
          before do
            methods_owner = instance_exec(&methods_owner_proc)
            methods_owner.send :define_method, method do |*args|
              [method, :result, args]
            end
            methods_owner.run_later method
          end
          it 'runs now and later' do
            expect(instance.public_send(method, *args)).to eq([method, :result, args])
            expect { instance.public_send(later_method, *args) }.
              to enqueue_job(described_class::Job).
              with(described_class.dump(instance), method.to_s, *args)
          end
        end
      end
    end

    include_examples 'for every method kind', -> { klass }

    context 'on module' do
      let(:klass) { Class.new(Hash).tap { |x| x.send(:include, mod) } }
      let(:mod) { Module.new.tap { |x| x.extend described_class } }
      include_examples 'for every method kind', -> { mod }
    end

    context 'for singleton class' do
      let(:mod) { Module.new.tap { |x| x.singleton_class.extend described_class } }
      let(:instance) { mod }

      context 'anonymous' do
        it 'raises error' do
          mod.singleton_class.run_later :test
          expect { mod.test_later }.to raise_error(ActiveJob::SerializationError)
        end
      end

      context 'with name' do
        before do
          name = 'Test::Module::Name'
          allow(mod).to receive(:name) { name }
          stub_const(name, mod)
        end
        include_examples 'for every method kind', -> { mod.singleton_class }
      end
    end
  end

  describe described_class::Job do
    let(:instance) { described_class.new }

    describe '#perform' do
      subject { instance.perform(target, method, *args) }
      let(:target) { double(:target) }
      let(:method) { 'some_method' }
      let(:args) { Array.new(3) { |i| double("arg#{i}") } }
      let(:result) { double(:result) }
      it 'invokes method on target with given args' do
        expect(target).to receive(method).with(*args) { result }
        should eq result
      end
    end
  end
end
