class RemoveUserIdClients < ActiveRecord::Migration
  def up
    remove_column :clients, :user_id
  end

  def down
  end
end
