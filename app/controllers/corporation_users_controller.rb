class CorporationUsersController < UsersController

  ENTITY_TYPE = 'Corporation'
  
  def domain_users_path
    corporation_users_path(@current_entity)
  end
  
end
