class CreateInitiatives < ActiveRecord::Migration
  def self.up
    create_table :initiatives do |t|
      t.string :name
      t.string :code
      t.float  :completed
      t.date   :beginning
      t.date   :end

      t.belongs_to :objective
      t.belongs_to :initiative

      t.timestamps
    end
  end

  def self.down
    drop_table :initiatives
  end
end
