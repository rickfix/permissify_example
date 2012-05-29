class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthlogicInterface
  helper_method :current_user_session, :current_user
end
