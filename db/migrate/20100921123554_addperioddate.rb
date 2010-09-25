class Addperioddate < ActiveRecord::Migration
  def self.up
    add_column :targets, :period_date, :date
  end

  def self.down
    remove_column :targets, :period_date
  end
end
