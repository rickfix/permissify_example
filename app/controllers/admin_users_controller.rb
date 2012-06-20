class AdminUsersController < UsersController

  ENTITY_TYPE = 'Admin'
  
  def domain_users_path
    admin_users_path
  end

end
