class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.integer :test_frequency
      t.boolean :send_emails
      t.boolean :send_sms

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
