class MarketingEngineController < EntityProductController

  protected
  
  def set_specific_nav
    @entity_category_path = "marketing_engine_path"
    @active_nav = "Marketing Engine"
    @active_nav_text = 'Marketing Engine'
  end
  
end
