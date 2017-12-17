class ApplicationController < ActionController::Base
  abstract!

  respond_to :html

  include ErrorResponses
  include SafeReferer

  protect_from_forgery with: :exception
end
