class MerchantDashboardController < DashboardController  
  def set_nav
    @active_tab = 'merchant'
    @active_section = 'Merchant Admin'
  end
end
