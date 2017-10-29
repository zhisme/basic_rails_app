RSpec.describe SafeReferer, type: :helper do
  describe '#url_or_back' do
    subject { ->(x = url, **options) { helper.url_or_back(x, options) } }
    let(:safe_referer) {}
    let(:js_back) { 'javascript:history.back()' }
    before { allow(helper).to receive(:safe_referer) { safe_referer } }

    it 'bypasses nil and other values' do
      [
        nil,
        double(:input),
      ].each { |val| expect(subject.call(val)).to eq val }
    end

    context 'when value is :back' do
      let(:url) { :back }
      its(:call) { should eq(redirect_fallback_path) }

      context 'when referer is safe' do
        let(:safe_referer) { '/any' }
        its(:call) { should eq(js_back) }
      end
    end

    context 'when value is string' do
      let(:url) { '/some/path' }

      it 'always returns input' do
        expect(subject.call).to eq url
        expect(subject.call(back_if: /condition/)).to eq url
        expect(subject.call(back_unless: /condition/)).to eq url
      end

      context 'when referer is safe' do
        let(:safe_referer) { '/referer/condition/path' }

        it 'returns js when referer equals' do
          expect(subject.call).to eq url
          expect(subject.call(safe_referer)).to eq js_back
        end

        it 'returns js when referer matches back_if' do
          expect(subject.call(back_if: /other/)).to eq(url)
          expect(subject.call(back_if: /condition/)).to eq(js_back)
        end

        it 'returns js when referer starts with back_if' do
          expect(subject.call(back_if: 'referer/cond')).to eq(url)
          expect(subject.call(back_if: '/referer/cond')).to eq(js_back)
        end

        it 'returns js when referer does not match back_unless' do
          expect(subject.call(back_unless: /other/)).to eq(js_back)
          expect(subject.call(back_unless: /condition/)).to eq(url)
        end

        it 'returns js when referer does not start with back_unless' do
          expect(subject.call(back_unless: 'referer/cond')).to eq(js_back)
          expect(subject.call(back_unless: '/referer/cond')).to eq(url)
        end
      end
    end
  end
end
