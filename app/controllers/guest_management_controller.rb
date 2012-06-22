class GuestManagementController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "guest_management_path"
    @active_nav = "Guest Management"
    @active_nav_text = 'Guest Management'
  end
  
end
