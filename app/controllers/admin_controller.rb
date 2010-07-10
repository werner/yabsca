class AdminController < ApplicationController
  before_filter :require_user

  def roles_privileges
    return_data=[]
    if params[:node].match(/src:root/)
      data=Role.all
      return_data=roles(data)
    end

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end
  
  def everything

    #it receives a node argument to make a regexp and then a select to a table
    #This is for reload the treeview everytime an user clicks on a node
    return_data=[]
    if params[:node].match(/src:root/)
      data=Organization.find_all_by_organization_id(0)
      return_data=everything_join_nodes_orgs(data)
    end
    
    if params[:node].match(/src:orgs/)
      id=params[:node].sub(/src:orgs/,"").to_i
      data=Organization.find_all_by_organization_id(id)
      if data.empty?
        data=Strategy.find_all_by_organization_id(id)
        return_data=everything_join_nodes_strat(data)
      else
        return_data=everything_join_nodes_orgs(data)
      end
    end

    if params[:node].match(/src:strats/)
      id=params[:node].sub(/src:strats/,"").to_i
      data=Perspective.find_all_by_strategy_id(id)
      return_data=everything_join_nodes_perspectives(data)
    end

    if params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      data=Objective.find_all_by_perspective_id(id)
      return_data=everything_join_nodes_objs(data)
    end

    if params[:node].match(/src:objs/)
      id=params[:node].sub(/src:objs/,"").to_i
      data=Objective.find(id).measures
      return_data=everything_join_nodes_measures(data)
    end

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

private

  def roles(tree)
    tree.map do |u|
        {:id => "src:roles"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "role"
        }
    end
  end
  
  def everything_join_nodes_orgs(tree)
    tree.map do |u|
        {:id => "src:orgs"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :leaf => (u.strategies.empty? and u.organizations.empty?)}
    end
  end

  def everything_join_nodes_strat(tree)
    tree.map do |u|
        {:id => "src:strats"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "strats",
        :leaf => u.perspectives.empty?}
    end
  end

  def everything_join_nodes_perspectives(tree)
    tree.map do |u|
      {:id => "src:persp"+u.id.to_s,
       :iddb => u.id,
       :text => u.name,
       :iconCls => "persp",
       :leaf => u.objectives.empty?}
    end
  end

  def everything_join_nodes_objs(tree)
    tree.map do |u|
      {:id => "src:objs"+u.id.to_s,
      :iddb => u.id,
      :text => u.name,
      :iconCls => "objs",
      :leaf => u.measures.empty?}
    end
  end

  def everything_join_nodes_measures(tree)
    tree.map do |u|
      {:id => "src:measure"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :code => u.code,
        :iconCls => "measure",
        :leaf => true}
    end
  end
  
end
