module SpecHelpers
  module ActiveJob
    module_function

    def with_adapter(adapter)
      old = ::ActiveJob::Base.queue_adapter
      ::ActiveJob::Base.queue_adapter = adapter
      yield
    ensure
      ::ActiveJob::Base.queue_adapter = old
    end

    def inlined(&block)
      with_adapter(:inline, &block)
    end

    RSpec.configuration.include self
    RSpec.configuration.around :example, :aj_adapter do |ex|
      ActiveJob.with_adapter(ex.metadata[:aj_adapter]) { ex.run }
    end
  end
end
