class CreateTargets < ActiveRecord::Migration
  def self.up
    create_table :targets do |t|
      t.float :goal
      t.float :achieved
      t.string :period
      
      t.belongs_to :measure

      t.timestamps
    end
  end

  def self.down
    drop_table :targets
  end
end
