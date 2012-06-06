class Initiative < ActiveRecord::Base
  belongs_to :objective
  belongs_to :responsible
  belongs_to :initiative
  has_many :initiatives

  def as_json(options = {})
    {
      id: self.id, name: self.name, code: self.code,
      completed: self.completed, objective_id: self.objective_id,
      initiative_id: self.initiative_id, responsible_id: self.responsible_id,
      beginning: (self.beginning.to_date rescue nil), end: (self.end.to_date rescue nil)
    }
  end

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
