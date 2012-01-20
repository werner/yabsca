class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string   "name"
      t.string   "code"
      t.float    "completed"
      t.date     "beginning"
      t.date     "end"
      t.integer  "objective_id"
      t.integer  "initiative_id"
      t.integer  "responsible_id"

      t.timestamps
    end
  end
end
