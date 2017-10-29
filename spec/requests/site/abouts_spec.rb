RSpec.describe Site::AboutsController do
  describe '#show' do
    subject { get controller_path(action: :show) }
    it { should be_ok }
  end

  describe '#ping' do
    subject { get controller_path(action: :ping) }
    it do
      should be_ok
      expect(response.body).to eq 'pong'
    end
  end
end
