module SpecHelpers
  # Module to use fixtures in any context.
  module FixtureFile
    class << self
      # Explicit path allows use it in any environment.
      def fixture_path
        @fixture_path ||= Rails.root.join 'spec', 'fixtures'
      end
    end

    def fixture_file_path(path)
      File.join(FixtureFile.fixture_path, path)
    end

    def fixture_file_upload(path, mime_type = nil, binary = false)
      path = fixture_file_path(path)
      Rack::Test::UploadedFile.new(path, mime_type, binary)
    end
  end
end
