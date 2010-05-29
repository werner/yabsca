class PresentationController < ApplicationController

  def index
  end

  def org_and_strat

    @organizations=Organization.all :order => :id

    @taken=[]
    return_data=[]
    return_data.push({
        :text=>"Organizations",
        :expanded=>true,
        :children=>join_nodes(@organizations)
    })

    return_data[0][:children].delete_if { |i| i.nil? }
    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def join_nodes(tree)
    tree.map do |u|
      unless @taken.include?(u.id)
        @taken.push(u.id)
        child={:id => u.id,
        :text => u.name,
        :children => join_nodes(u.organizations)}
        child[:leaf]=true if u.organizations.empty?
        child
      end
    end
  end


end
