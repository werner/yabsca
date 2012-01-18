class CreatePerspectives < ActiveRecord::Migration
  def change
    create_table :perspectives do |t|
      t.string :name
      t.integer :strategy_id

      t.timestamps
    end
  end
end
