class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.string :name
      t.text :description
      t.text :strategy_map
      t.text :strategy_map_svg
      t.integer :organization_id, :default => 0

      t.timestamps
    end
  end
end
