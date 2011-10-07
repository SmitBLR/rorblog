class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.trackable
      t.database_authenticatable :null => false

      t.string :service_id, :unique => true, :null => false
      t.string :service_type, :null => false
      t.string :name
      t.string :link
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
