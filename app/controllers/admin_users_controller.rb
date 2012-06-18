class AdminUsersController < UsersController
  def domain_users_path
    admin_users_path
  end
  
  def set_nav
    @active_tab = 'admin'
    @active_section = 'Admin'
    @active_nav = 'Admin Users'
    @domain_type = 'Admin'
    @domain_category = :admin_users
    @current_entity = @entity = Admin.first
    @entity_ability_category = :admin
  end
end
