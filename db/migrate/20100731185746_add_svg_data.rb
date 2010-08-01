class AddSvgData < ActiveRecord::Migration
  def self.up
    add_column :strategies, :strategy_map_svg, :text
  end

  def self.down
    remove_column :strategies, :strategy_map_svg
  end
end
