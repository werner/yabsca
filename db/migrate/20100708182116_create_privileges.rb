class CreatePrivileges < ActiveRecord::Migration
  def self.up
    create_table :privileges do |t|
      t.integer :module
      t.boolean :creating
      t.boolean :reading
      t.boolean :updating
      t.boolean :deleting

      t.integer :module_id
      
      t.belongs_to :role
      t.timestamps
    end
  end

  def self.down
    drop_table :privileges
  end
end
