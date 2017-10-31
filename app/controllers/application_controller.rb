class ApplicationController < ActionController::Base
  abstract!

  respond_to :html
  self.responder = Responders::Basic
  include Responders::Basic::ControllerHelpers

  include ErrorResponses
  include SafeReferer

  protect_from_forgery with: :exception
end
