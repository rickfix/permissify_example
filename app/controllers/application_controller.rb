class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthlogicInterface
  include Permissify::Controller
  helper_method :current_user_session, :current_user, :current_entity, :allowed_to?, :subscribed_to?
  
  def current_entity
    # nil # TODO
    @entity ? @entity : current_user.entity
  end

end
