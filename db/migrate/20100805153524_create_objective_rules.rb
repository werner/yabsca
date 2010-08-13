class CreateObjectiveRules < ActiveRecord::Migration
  def self.up
    create_table :objective_rules do |t|
      t.belongs_to :objective
      t.belongs_to :role
      t.boolean     :creating
      t.boolean     :reading
      t.boolean     :updating
      t.boolean     :deleting

      t.timestamps
    end
  end

  def self.down
    drop_table :objective_rules
  end
end
