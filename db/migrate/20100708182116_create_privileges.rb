class CreatePrivileges < ActiveRecord::Migration
  def self.up
    create_table :privileges do |t|
      
      t.integer :privilege

      t.belongs_to :role
      t.timestamps
    end
  end

  def self.down
    drop_table :privileges
  end
end