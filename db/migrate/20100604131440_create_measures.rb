class CreateMeasures < ActiveRecord::Migration
  def self.up
    create_table :measures do |t|
      t.string :code
      t.string :name
      t.text :description
      t.string :challenge
      t.float :satisfactory
      t.float :alert
      t.string :frecuency
      t.date :period_from
      t.date :period_to
      t.belongs_to :unit
      
      t.timestamps
    end
  end

  def self.down
    drop_table :measures
  end
end
