class CreateSmsArchives < ActiveRecord::Migration
  def change
    create_table :sms_archives do |t|
      t.string :to
      t.string :body
      t.string :from
      t.string :campaign
      t.string :version
      t.string :status
      t.string :sms_id

      t.timestamps
    end
    
    add_index :sms_archives, :sms_id
  end
end
