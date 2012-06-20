class BrandUsersController < UsersController

  ENTITY_TYPE = 'Brand'

  def domain_users_path
    brand_users_path(@current_entity)
  end
  
end
