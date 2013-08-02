class AddIndexSmsIdMessages < ActiveRecord::Migration
  def up
    add_index :messages, :SmsId, :unique => true
  end

  def down
  end
end
