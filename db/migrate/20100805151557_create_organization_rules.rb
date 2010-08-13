class CreateOrganizationRules < ActiveRecord::Migration
  def self.up
    create_table :organization_rules do |t|
      t.belongs_to :organization
      t.belongs_to :role
      t.boolean     :creating
      t.boolean     :reading
      t.boolean     :updating
      t.boolean     :deleting
      t.timestamps
    end
  end

  def self.down
    drop_table :organization_rules
  end
end
