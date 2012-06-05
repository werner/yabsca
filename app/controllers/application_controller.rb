class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      render :js => "Ext.ComponentQuery.query('viewport')[0].down('panel').getLayout().setActiveItem(0)"
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
