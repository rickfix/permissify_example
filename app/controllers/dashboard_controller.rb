class DashboardController < ApplicationController
  before_filter :require_user
  before_filter :set_nav
  
  def index
  end
end
