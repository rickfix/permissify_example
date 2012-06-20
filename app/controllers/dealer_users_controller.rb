class DealerUsersController < UsersController

  ENTITY_TYPE = 'Dealer'
  
  def domain_users_path
    dealer_users_path(@current_entity)
  end
  
end
