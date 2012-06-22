class LoyaltyController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "loyalty_path"
    @active_nav = "Loyalty"
    @active_nav_text = 'Loyalty'
  end
  
end
