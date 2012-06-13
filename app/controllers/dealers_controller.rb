class DealersController < EntityController

  def set_nav
    @active_tab = 'dealer'
    @active_section = 'Dealer Admin'
    @active_nav = 'Dealers'
    @entity_list = Dealer.all
    @new_entity = Dealer.new
    @create_path = new_dealer_path
    @add_label = 'new dealer'
    @index_columns = 1
  end

end
