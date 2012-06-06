class CorporateUsersController < UsersController
  def domain_users_path
    corporate_users_path
  end
  
  def set_nav
    @active_tab = 'corporate'
    @active_section = 'Corporate Admin'
    @active_nav = 'Corporate Users'
    @domain_type = 'Corporate'
    @domain_category = :corporate_users
  end
end
