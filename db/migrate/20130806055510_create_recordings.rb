class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :tag
      t.string :url
      t.integer :user_id, :null => false
      t.integer :client_id, :null => false
      t.timestamps
    end
  end
end
