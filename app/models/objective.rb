class Objective < ActiveRecord::Base
  belongs_to :perspectives
  belongs_to :objective
  has_many :objectives
  has_many :initiatives
  has_and_belongs_to_many :measures
  
  def self.tree(id_node)
    node_collects = lambda { |node_id, field|
      id = id_node.sub(node_id,"").to_i        
      where(field => id).collect { |objective|
        node objective
      }
    } 
    if id_node.match(/src:persp/)
      node_collects.call /src:persp/, :perspective_id
    elsif id_node.match(/src:objs/) 
      node_collects.call /src:objs/, :objective_id
    else
      []
    end
  end

  def get_gantt
    initiatives.collect { |i| 
      {
        name: i.name,
        desc: i.name,
        values: [{
          from: "/Date(#{i.beginning.to_time.to_i})",
          to: "/Date(#{i.end.to_time.to_i})",
          desc: i.name,
          label: i.name
        }]
      }
    }
  end

  private 

  def self.node(objective)
    { :id => 'src:objs' + objective.id.to_s,
      :iddb => objective.id,
      :text => objective.name,
      :iconCls => 'objs',
      :type => 'objective',
      :leaf => objective.objectives.empty?
    }
  end
end
