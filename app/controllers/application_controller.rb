class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthlogicInterface
  include Permissify::Controller
  helper_method :current_user_session, :current_user, :current_entity, :allowed_to?, :subscribed_to?
  
  def current_entity
    @entity ? @entity : current_user.entity
  end

  def derive_entity_type_values
    @entity_id ||= params[:id]
    @entity_class = eval(@entity_type.classify)
    @entity_association = @entity_type.pluralize.downcase.to_sym
    @entity_ability_category = @entity_type.pluralize.downcase.to_sym
    @entity_name = @entity_type.singularize.downcase
    @entity_base_route ||= send("#{@entity_type.pluralize.downcase}_url")
    @entity_key = "#{@entity_type.downcase}_id".to_sym
    @is_entity_path ||= false
    @active_tab ||= "#{@entity_type.downcase.pluralize}"
    @active_nav ||= "#{@entity_type.titleize.singularize} #{@active_nav_text}"
    @active_section ||= "#{@entity_type.titleize.singularize} Admin"
  end
end
