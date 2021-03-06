class UsersController < ApplicationController
  before_filter :require_user
  before_filter :set_nav
  before_filter :derive_entity_type_values
  before_filter :find_current_entity
  before_filter :set_domain_roles
  before_filter :new_user, :only => [:create, :new]
  before_filter :find_user, :only => [:edit, :update, :destroy]
  before_filter :set_and_save_user, :only => [:create, :update]
  
  helper_method :domain_users_path
  
  def index
    @users = @current_entity.users
  end

  def new
  end
  
  def create
  end

  def edit
  end
  
  def update
  end
  
  def destroy
    if @user.respond_to?(:deleted_at)
      @user.update_attribute(:deleted_at, Time.now)
    else
      @user.destroy
    end
    redirect_to domain_users_path
  end
  
  protected

  def set_nav # a whole lot of name coupling...
    @entity_type = self.class::ENTITY_TYPE
    @entity_category_path = "#{@entity_type.downcase}_users_path"
    @active_nav_text = 'Users'
    @domain_category = "#{@entity_type.downcase.to_sym}_users".to_sym
    return unless @entity_type == AdminUsersController::ENTITY_TYPE
    @active_tab = 'admin'
    @active_section = 'Admin'
  end
  
  def set_domain_roles
    @domain_roles = Role.find_all_by_domain_type( @entity_type )
  end
  
  def new_user
    @user = @current_entity.users.new
    @permissions_action = :create
  end
  
  def find_user
    @user = User.find(params[:id]) if params[:id]
    @permissions_action = :update
  end
  
  def set_and_save_user
    @user.login = params[:user][:login].ljust(6, '0')
    role_ids = params[:user][:role_ids]
    @user.role_ids = role_ids if role_ids
    @user.password = 'password1'
    @user.password_confirmation = 'password1'
    @user.email = "#{@user.login.gsub(' ','')}@permissfy.com"
    if @user.save
      flash[:success] = "Saved '#{@user.login}'"
      redirect_to domain_users_path
    else
      logger.debug("user errors: #{@user.errors.full_messages.join(',')}")
      render :template => 'users/edit'
    end
  rescue
    logger.debug("user exception: #{$!.message}, backtrace: #{$!.backtrace}")
  end

  def find_current_entity
    return if @current_entity
    @current_entity = @entity = current_user.entity.send(@entity_association).select{ |e| e.id == params[@entity_key].to_i }.first
    @current_entity ||= @entity ||=  current_user.entity
  end
end
