class MeasuresRoles < ActiveRecord::Migration
  def self.up
    create_table :measures_roles, :id => false do |t|
      t.integer :role_id
      t.integer :measure_id
    end
  end

  def self.down
    drop_table :measures_roles
  end
end
