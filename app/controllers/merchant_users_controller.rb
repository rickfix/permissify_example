class MerchantUsersController < UsersController
  def domain_users_path
    merchant_merchant_users_path(@current_entity)
  end
  
  def set_nav
    @active_tab = 'merchants'
    @active_section = 'Merchant Admin'
    @active_nav = 'Merchant Users'
    @domain_type = 'Merchant'
    @domain_category = :merchant_users
    @entity_key = :merchant_id
    @entity_association = :merchants
  end
end
