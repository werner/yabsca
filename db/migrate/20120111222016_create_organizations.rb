class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :vision
      t.text :goal
      t.text :description
      t.integer :organization_id, :default => 0

      t.timestamps
    end
  end
end
