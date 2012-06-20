class MerchantUsersController < UsersController

  ENTITY_TYPE = 'Merchant'
  
  def domain_users_path
    merchant_users_path(@current_entity)
  end
  
end
