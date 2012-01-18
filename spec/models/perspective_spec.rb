require 'spec_helper'

describe Perspective do

  before do
    perspective = Perspective.create!(id: 1, name: "Perspective1", strategy_id: 1)
    Perspective.create!(id: 2, name: "Perspective2", strategy_id: 1)
    Perspective.create!(id: 3, name: "Perspective3", strategy_id: 1)
    objective = Objective.create!(id: 1, name: "Objective1", perspective_id: perspective.id) 
    Objective.create!(id: 2, name: "Objective2", perspective_id: perspective.id)
    Objective.create!(id: 3, name: "Objective3", perspective_id: perspective.id)
    Objective.create!(id: 4, name: "Objective4", objective_id: objective.id)
    Objective.create!(id: 5, name: "Objective5", objective_id: objective.id)
  end

  it "should output json format to perspectives nodes" do
    tree = [{:id => "src:persp1", :iddb => 1, :text => "Perspective1", 
             :iconCls => 'persp', :type => 'perspective', :leaf => false},
            {:id => "src:persp2", :iddb => 2, :text => "Perspective2", 
             :iconCls => 'persp', :type => 'perspective', :leaf => true},
            {:id => "src:persp3", :iddb => 3, :text => "Perspective3", 
             :iconCls => 'persp', :type => 'perspective', :leaf => true}]

    result = Perspective.tree('src:strats1') + Objective.tree('src:strats1')
    result.should eq(tree)
  end

  it "should output json format to perspectives and objectives nodes" do
    tree = [{:id => "src:objs1", :iddb => 1, :text => "Objective1", 
             :iconCls => 'objs', :type => 'objective', :leaf => false},
            {:id => "src:objs2", :iddb => 2, :text => "Objective2", 
             :iconCls => 'objs', :type => 'objective', :leaf => true},
            {:id => "src:objs3", :iddb => 3, :text => "Objective3", 
             :iconCls => 'objs', :type => 'objective', :leaf => true}]

    result = Perspective.tree('src:persp1') + Objective.tree('src:persp1')
    result.should eq(tree)
  end

  it "should output json format to perspectives and objectives nodes" do
    tree = [{:id => "src:objs4", :iddb => 4, :text => "Objective4", 
             :iconCls => 'objs', :type => 'objective', :leaf => true},
            {:id => "src:objs5", :iddb => 5, :text => "Objective5", 
             :iconCls => 'objs', :type => 'objective', :leaf => true}]

    result = Perspective.tree('src:objs1') + Objective.tree('src:objs1')
    result.should eq(tree)
  end
end
