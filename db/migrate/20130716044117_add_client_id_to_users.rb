class AddClientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :client_id, :integer
    drop_table :users_clients
  end
end
