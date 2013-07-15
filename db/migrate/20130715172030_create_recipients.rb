class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :CountryCode, :default => '+1'
      t.string :Phone, :null => false
      t.boolean :OptOut, :default => false

      t.timestamps
    end
  end
end
