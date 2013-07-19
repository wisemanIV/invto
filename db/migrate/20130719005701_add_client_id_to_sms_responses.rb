class AddClientIdToSmsResponses < ActiveRecord::Migration
  def change
    add_column :sms_responses, :client_id, :integer
  end
end
