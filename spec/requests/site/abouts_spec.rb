RSpec.describe Site::AboutsController do
  describe '#show' do
    subject { get controller_path(action: :show) }
    it { should eq 200 }
  end

  describe '#ping' do
    subject { get controller_path(action: :ping) }
    it do
      should eq 200
      expect(response.body).to eq 'pong'
    end
  end
end
