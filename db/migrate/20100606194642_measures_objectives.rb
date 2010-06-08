class MeasuresObjectives < ActiveRecord::Migration
  def self.up
    create_table :measures_objectives, :id => false do |t|
      t.integer :objective_id
      t.integer :measure_id
    end
  end

  def self.down
    drop_table :measures_objectives
  end
end
