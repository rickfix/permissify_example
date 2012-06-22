class WebpageBuilderController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "webpage_builder_path"
    @active_nav = "Webpage Builder"
    @active_nav_text = 'Webpage Builder'
  end
  
end
