class EgiftController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "egift_path"
    @active_nav = "eGift"
    @active_nav_text = 'eGift'
  end
  
end
