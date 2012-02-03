class SessionsController < ApplicationController
  skip_before_filter :authorize

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { success: true }
  end
end
