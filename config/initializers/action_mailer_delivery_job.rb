# This class is not inherited from ApplicationJob, so setup manually.
ActionMailer::DeliveryJob.class_eval do
  include Rollbar::ActiveJob
end
