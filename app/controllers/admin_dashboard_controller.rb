class AdminDashboardController < DashboardController  
  def set_nav
    @active_tab = 'admin'
    @active_section = 'Admin'
  end
end
