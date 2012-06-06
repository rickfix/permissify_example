class BrandUsersController < UsersController
  def domain_users_path
    brand_users_path
  end
  
  def set_nav
    @active_tab = 'brand'
    @active_section = 'Brand Admin'
    @active_nav = 'Brand Users'
    @domain_type = 'Brand'
    @domain_category = :brand_users
  end
end
