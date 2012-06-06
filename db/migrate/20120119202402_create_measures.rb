class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string   :code
      t.string   :name
      t.text     :description
      t.integer  :challenge
      t.float    :excellent
      t.float    :alert
      t.integer  :frecuency
      t.date     :period_from
      t.date     :period_to
      t.integer  :unit_id
      t.integer  :responsible_id
      t.string   :formula
      t.timestamps
    end
  end
end
