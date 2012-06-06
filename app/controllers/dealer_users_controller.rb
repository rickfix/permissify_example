class DealerUsersController < UsersController
  def domain_users_path
    dealer_users_path
  end
  
  def set_nav
    @active_tab = 'dealer'
    @active_section = 'Dealer Admin'
    @active_nav = 'Dealer Users'
    @domain_type = 'Dealer'
    @domain_category = :dealer_users
  end
end
