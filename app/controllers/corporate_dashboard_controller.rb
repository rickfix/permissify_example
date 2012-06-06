class CorporateDashboardController < DashboardController  
  def set_nav
    @active_tab = 'corporate'
    @active_section = 'Corporate Admin'
  end
end
