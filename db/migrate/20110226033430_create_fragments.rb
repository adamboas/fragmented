class CreateFragments < ActiveRecord::Migration
  def self.up
    create_table :fragments do |table|
      table.text :contents

      table.timestamps
    end
  end

  def self.down
    drop_table :fragments
  end
end
