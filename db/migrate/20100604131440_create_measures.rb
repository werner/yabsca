class CreateMeasures < ActiveRecord::Migration
  def self.up
    create_table :measures do |t|
      t.text :description
      t.string :name
      t.double :target
      t.double :satisfactory
      t.double :alert
      t.string :frecuency
      t.belongs_to :unit
      
      t.timestamps
    end
  end

  def self.down
    drop_table :measures
  end
end
