class OnlineOrderingController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "online_ordering_path"
    @active_nav = "Online Ordering"
    @active_nav_text = 'Online Ordering'
  end
  
end
