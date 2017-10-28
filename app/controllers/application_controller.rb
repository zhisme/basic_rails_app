class ApplicationController < ActionController::Base
  abstract!
  protect_from_forgery with: :exception
end
