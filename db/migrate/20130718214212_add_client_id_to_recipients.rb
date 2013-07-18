class AddClientIdToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :client_id, :integer
  end
end
