class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  layout 'login'

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      domain_type = @user_session.user.primary_domain_type
      if domain_type
        redirect_to (et = @user_session.user.entity_type) == 'Admin' ? admins_path : send("#{domain_type.downcase}_path", @user_session.user.entity)
      else
        redirect_to '/logout'
      end
    else
      logger.debug("*** errors: #{@user_session.errors.full_messages.join(',')}")
      flash[:error] = "nuh uh : try agin..."
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
