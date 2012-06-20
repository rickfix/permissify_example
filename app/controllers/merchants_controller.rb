class MerchantsController < EntityController  
  def set_nav
    @active_tab = 'merchants'
    @active_section = @active_nav = 'Merchant Admin'
    @entity_class = Merchant
    @entity_ability_category = :merchants
    @entity_base_route = merchants_url
    @index_columns = 1
  end
end
