class AddFormula < ActiveRecord::Migration
  def self.up
    add_column :measures, :formula, :string
  end

  def self.down
    remove_column :measures, :formula
  end
end
