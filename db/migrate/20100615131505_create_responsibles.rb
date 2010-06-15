class CreateResponsibles < ActiveRecord::Migration
  def self.up
    create_table :responsibles do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :responsibles
  end
end
