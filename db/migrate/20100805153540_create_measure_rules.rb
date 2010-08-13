class CreateMeasureRules < ActiveRecord::Migration
  def self.up
    create_table :measure_rules do |t|
      t.belongs_to :measure
      t.belongs_to :role
      t.boolean     :creating
      t.boolean     :reading
      t.boolean     :updating
      t.boolean     :deleting

      t.timestamps
    end
  end

  def self.down
    drop_table :measure_rules
  end
end
