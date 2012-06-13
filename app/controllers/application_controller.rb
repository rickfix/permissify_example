class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthlogicInterface
  include Permissify::Controller
  include PermissifiedController
  helper_method :current_user_session, :current_user, :current_entity, :allowed_to?, :subscribed_to?
  
  def current_entity
    nil # TODO
  end

end
