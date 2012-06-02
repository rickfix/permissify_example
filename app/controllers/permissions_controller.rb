class PermissionsController < ApplicationController
  before_filter :require_user
  # layout 'admin_settings'
  # before_filter :require_admin
  # before_filter :find_restaurant_or_dealer
  # before_filter :find_entity_from_route
  before_filter :set_permissions_class
  before_filter :find_permissions_object, :only => [:edit, :update, :destroy]
  before_filter :set_nav

  def index
    render :template => 'permissions/index'
  end

  def edit
    rjs_response
  end
  
  def destroy
    if @permissions_object.respond_to?(:deleted_at)
      @permissions_object.update_attribute(:deleted_at, Time.now)
    else
      @permissions_object.destroy
    end
    rjs_response
  end
  
  def create
    @permissions_object = @permissions_class.new
    @permissions_object.name = params[:role][:name]
    @permissions_object.save
    set_permissions_object
    @response_message = @permissions_object.errors.full_messages.join(', ')
    rjs_response
  end
  
  def update
    permission_attributes = params[@permissions_name]
    permission_attributes ||= {}
    class_attributes = params[@corresponding_class_params_key]
    class_attributes ||= {}
    # @saved = @permissions_object.update_attributes class_attributes.merge(permission_attributes)
    attrs = class_attributes.merge(permission_attributes)
    @permissions_object.domain_type = attrs[:domain_type]
    @permissions_object.managed_by = attrs[:managed_by]
    @permissions_object.can_manage_roles = attrs[:can_manage_roles]
    @permissions_object.permissions = attrs[:permissions]
    # @permissions_object.attributes = class_attributes.merge(permission_attributes)
    @saved = @permissions_object.save
    rjs_response
  end
  
  def set_the_permissions_class(the_class, corresponding_class_params_key, prefix, applicability, permissions_header, sort_field = :name)
    @permissions_prefix = prefix
    @permissions_class  = the_class
    @corresponding_class_params_key = corresponding_class_params_key
    @applicability = applicability
    # relative pathing isn't working in devint (ok in dev): working around with post-deploy symlinks
    @view_directory = Rails.env == 'development' ? '../permissions/' : ''
    @permissions_name = @permissions_prefix.chop
    @permissions_category = @permissions_name+'s'
    @sort_field = sort_field
    @index_columns = corresponding_class_params_key == :role ? 6 : 4
    @permissions_header = permissions_header
  end
  
  def find_permissions_object
    @permissions_object = @permissions_class.find(params[:id])
    set_permissions_object
  end

  def rjs_response
    render :action => "#{@view_directory}#{params[:action]}_response"
  end

  def set_nav
    @active_tab = 'admin'
    @active_section = 'Admin'
    @active_nav = 'Roles'
  end
end