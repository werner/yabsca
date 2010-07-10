class UsersController < ApplicationController
  before_filter :require_user

  def index
    users=User.all

    return_data=[]
    return_data=users.collect{|u|{
        :id => u.id,
        :text => u.login,
        :leaf => true,
        :iconCls => "user"
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end
  
  def create
    self.default_creation(User, params[:user])
  end
  
  def edit
    user=User.find(params[:id])
    return_data={}
    return_data[:success]=true
    return_data[:data] = {
      "user[login]"=>user.login,
      "user[email]"=>user.email
    }
    respond_to do |format|
      format.json { render :json => return_data }
    end
  end
  
  def update
    self.default_updating(User, params[:id], params[:user])
  end

  def destroy
    self.default_destroy(User, params[:id])
  end
end
