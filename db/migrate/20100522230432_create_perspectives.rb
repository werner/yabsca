class CreatePerspectives < ActiveRecord::Migration
  def self.up
    create_table :perspectives do |t|
      t.string :name
      t.belongs_to :strategy
      
      t.timestamps
    end
  end

  def self.down
    drop_table :perspectives
  end
end
