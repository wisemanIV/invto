class AddClientIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :client_id, :integer
  end
end
