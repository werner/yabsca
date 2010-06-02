class CreateObjectives < ActiveRecord::Migration
  def self.up
    create_table :objectives do |t|
      t.string :name
      t.belongs_to :perspective
      t.belongs_to :objective
      
      t.timestamps
    end
  end

  def self.down
    drop_table :objectives
  end
end
