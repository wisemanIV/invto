class AddSmsIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :SmsId, :string
    add_column :messages, :TwilioResponse, :string
  end
end
