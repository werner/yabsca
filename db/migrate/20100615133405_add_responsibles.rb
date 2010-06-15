class AddResponsibles < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :responsible_id, :string
    add_column :measures, :responsible_id, :string
  end

  def self.down
    remove_column :initiatives, :responsible_id
    remove_column :measures, :responsible_id
  end
end
