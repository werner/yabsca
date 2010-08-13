class CreateStrategyRules < ActiveRecord::Migration
  def self.up
    create_table :strategy_rules do |t|
      t.belongs_to :strategy
      t.belongs_to :role
      t.boolean     :creating
      t.boolean     :reading
      t.boolean     :updating
      t.boolean     :deleting

      t.timestamps
    end
  end

  def self.down
    drop_table :strategy_rules
  end
end
