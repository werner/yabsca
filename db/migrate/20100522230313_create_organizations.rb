class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.text :vision
      t.text :goal
      t.text :description
      t.belongs_to :organization

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
