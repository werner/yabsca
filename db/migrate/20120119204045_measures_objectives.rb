class MeasuresObjectives < ActiveRecord::Migration
  def change
    create_table :measures_objectives, :id => false do |t|
      t.integer :measure_id
      t.integer :objective_id
    end

    add_index(:measures_objectives, [:measure_id, :objective_id], :unique => true)
  end

end
