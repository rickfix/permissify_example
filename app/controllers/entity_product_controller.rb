class EntityProductController < ApplicationController
  before_filter :require_user
  before_filter :set_specific_nav
  before_filter :set_nav
  before_filter :find_current_entity
  
  protected
  
  def find_current_entity
    @current_entity = @entity = current_user.entity.send(@entity_association).select{ |e| e.id == params[@entity_key].to_i }.first
    @current_entity ||= @entity ||= current_user.entity
  end
  
  def set_specific_nav
    @entity_category_path = "guest_management_path"
    @active_nav = "Guest Management"
    @active_nav_text = 'Guest Management'
  end
  
  def set_nav
    @entity_type = params[:entity_type]
    @entity_id = params[:id]
    @entity_key = :entity_id
    @is_entity_path = true
    
    @active_tab = @entity_type.downcase.pluralize
    @active_section = "#{@entity_type.titleize.singularize} Admin"
    
    @entity_class = eval(@entity_type.classify)
    @entity_association = @entity_type.pluralize.downcase
    @entity_ability_category = @entity_type.pluralize.downcase.to_sym
    # @entity_base_route = send("#{@entity_type.pluralize.downcase}_url")
    @entity_name = @entity_type.singularize.downcase

    @domain_type = @entity_type
    @domain_category = "#{@entity_type.downcase.to_sym}_users".to_sym
    @entity_association = @entity_type.downcase.pluralize.to_sym
  end
  
end
