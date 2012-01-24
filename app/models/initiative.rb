class Initiative < ActiveRecord::Base
  belongs_to :objective
  belongs_to :responsible
  belongs_to :initiative
  has_many :initiatives

  def self.tree(id_node)
    id = id_node.sub(/src:objs/,"").to_i
    Objective.find(id).initiatives.collect { |initiative|
      node initiative
    }
  rescue ActiveRecord::RecordNotFound
    []
  end

  private 

  def self.node(initiative)
    { :id => 'src:initiative' + initiative.id.to_s,
      :iddb => initiative.id,
      :text => initiative.name,
      :iconCls => 'initiative',
      :type => 'initiative',
      :leaf => initiative.initiatives.empty? 
    }
  end

end
