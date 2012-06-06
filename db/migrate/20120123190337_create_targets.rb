class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.float    :goal
      t.float    :achieved
      t.string   :period
      t.integer  :measure_id
      t.date     :period_date

      t.timestamps
    end
  end
end
