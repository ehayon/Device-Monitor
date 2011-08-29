class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.string :ip
      t.integer :port
      t.datetime :last_checked
      t.boolean :last_state
      t.boolean :disabled
      t.integer :up_emails_sent
      t.integer :down_emails_sent
      t.integer :times_up
      t.integer :times_down
      t.integer :folder_id

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
