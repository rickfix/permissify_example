class DealerDashboardController < DashboardController  
  def set_nav
    @active_tab = 'dealer'
    @active_section = 'Dealer Admin'
  end
end
