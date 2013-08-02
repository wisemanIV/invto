class AddIdsSmsArchives < ActiveRecord::Migration
  def up
    add_column :sms_archives, :client_id, :integer
    add_column :sms_archives, :user_id, :integer
  end

  def down
  end
end
