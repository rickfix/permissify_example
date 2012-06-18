class BrandUsersController < UsersController
  def domain_users_path
    brand_brand_users_path(@current_entity)
  end
  
  def set_nav
    @active_tab = 'brands'
    @active_section = 'Brand Admin'
    @active_nav = 'Brand Users'
    @domain_type = 'Brand'
    @domain_category = :brand_users
    @entity_key = :brand_id
    @entity_association = :brands
  end
end
