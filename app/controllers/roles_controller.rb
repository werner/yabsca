class RolesController < ApplicationController

  def index
    roles=Role.all

    return_data=[]
    
    return_data=roles.collect { |u| {
      :id => 'role'+u.id.to_s,
      :iddb => u.id,
      :text => u.name,
      :iconCls=> "role",
      :type=>"role",
      :children => u.users.map {|i| {
          :id => 'user'+i.id.to_s,
          :iddb => i.id,
          :text => i.login,
          :leaf => true,
          :iconCls => "user",
          :type => "user"
        }}
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Role, params[:role],nil,nil)
  end

  def update
    self.default_updating(Role, params[:id], params[:role],nil,nil)
  end

  def destroy
    self.default_destroy(Role, params[:id],nil,nil)
  end
end
