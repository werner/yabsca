class Measure < ActiveRecord::Base
  has_and_belongs_to_many :objectives

  validates_presence_of :name
  validates_uniqueness_of :code

  def self.tree(id_node)
    id = id_node.sub(/src:objs/,"").to_i
    Objective.find(id).measures.collect { |measure|
      node measure
    }
  rescue ActiveRecord::RecordNotFound
    []
  end

  private 

  def self.node(measure)
    { :id => 'src:measure' + measure.id.to_s,
      :iddb => measure.id,
      :text => measure.name,
      :iconCls => 'measure',
      :type => 'measure',
      :leaf => true 
    }
  end

end
