class CreatePerspectiveRules < ActiveRecord::Migration
  def self.up
    create_table :perspective_rules do |t|
      t.belongs_to :perspective
      t.belongs_to :role
      t.boolean     :creating
      t.boolean     :reading
      t.boolean     :updating
      t.boolean     :deleting

      t.timestamps
    end
  end

  def self.down
    drop_table :perspective_rules
  end
end
