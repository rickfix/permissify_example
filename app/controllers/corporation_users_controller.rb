class CorporationUsersController < UsersController
  def domain_users_path
    corporation_users_path
  end
  
  def set_nav
    @active_tab = 'corporation'
    @active_section = 'Corporation Admin'
    @active_nav = 'Corporation Users'
    @domain_type = 'Corporation'
    @domain_category = :corporation_users
  end
end
