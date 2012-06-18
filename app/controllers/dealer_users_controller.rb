class DealerUsersController < UsersController
  def domain_users_path
    dealer_dealer_users_path(@current_entity)
  end
  
  def set_nav
    @active_tab = 'dealers'
    @active_section = 'Dealer Admin'
    @active_nav = 'Dealer Users'
    @domain_type = 'Dealer'
    @domain_category = :dealer_users
    @entity_key = :dealer_id
    @entity_association = :dealers
  end
end
