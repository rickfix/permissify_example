class MerchantUsersController < UsersController
  def domain_users_path
    merchant_users_path
  end
  
  def set_nav
    @active_tab = 'merchant'
    @active_section = 'Merchant Admin'
    @active_nav = 'Merchant Users'
    @domain_type = 'Merchant'
    @domain_category = :merchant_users
  end
end
