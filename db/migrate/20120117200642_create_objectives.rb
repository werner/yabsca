class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :name
      t.integer :perspective_id
      t.integer :objective_id

      t.timestamps
    end
  end
end
