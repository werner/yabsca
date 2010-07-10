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

  def create_priv

    condition=[]
    measures=[]
    if params[:node].match(/src:orgs/)
      id=params[:node].sub(/src:orgs/,"").to_i
      condition=["organization_id=?",id]
    end

    if params[:node].match(/src:strats/)
      id=params[:node].sub(/src:strats/,"").to_i
      condition=["strategy_id=?",id]
    end

    if params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      condition=["perspective_id=?",id]
    end

    if params[:node].match(/src:objs/)
      id=params[:node].sub(/src:objs/,"").to_i
      condition=["objective_id=?",id]
    end
    
    measures=Measure.find(:all,
      :joins=>"inner join measures_objectives on measures_objectives.measure_id=measures.id
               inner join objectives on objectives.id=measures_objectives.objective_id
               inner join perspectives on perspectives.id=objectives.perspective_id
               inner join strategies on strategies.id=perspectives.strategy_id",
      :conditions=>condition) unless condition.empty?

    if params[:node].match(/src:measure/)
      id=params[:node].sub(/src:measure/,"").to_i
      measures=Measure.find(:all,id)
    end

    measures.each do |i|
      MeasuresRoles.create!({:role_id=>params[:role_id],:measure_id=>i.id})
    end

    respond_to do |format|
      format.json { render :json => {:success => true,:measures=>measures} }
    end
    
  end
  
  def create
    self.default_creation(Role, params[:role])
  end

  def update
    self.default_updating(Role, params[:id], params[:role])
  end

  def destroy
    self.default_destroy(Role, params[:id])
  end
end
