class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end
  
  def create
    self.default_creation(UserSession, params[:user_session],nil,nil)
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end
end
