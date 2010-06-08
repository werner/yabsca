class CreateTargets < ActiveRecord::Migration
  def self.up
    create_table :targets do |t|
      t.float :goal, :limit => 25
      t.float :achieved, :limit => 25
      t.string :period
      
      t.belongs_to :measure

      t.timestamps
    end
  end

  def self.down
    drop_table :targets
  end
end
