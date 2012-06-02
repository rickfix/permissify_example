class DashboardController < ApplicationController
  before_filter :require_user
  
  def index
    @active_tab ||= current_user.primary_domain_type.downcase
    @active_section ||= @active_tab == 'admin' ? 'Admin' : @active_tab + ' Admin'
  end
end
