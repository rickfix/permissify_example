class BrandDashboardController < DashboardController  
  def set_nav
    @active_tab = 'brand'
    @active_section = 'Brand Admin'
  end
end
