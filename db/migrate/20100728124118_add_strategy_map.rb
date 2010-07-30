class AddStrategyMap < ActiveRecord::Migration
  def self.up
    add_column :strategies, :strategy_map, :text
  end

  def self.down
    remove_column :strategies, :strategy_map
  end
end
