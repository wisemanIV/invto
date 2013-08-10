class AddResponseToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :response, :text
    add_column :messages, :response_code, :string
    add_column :sms_archives, :response, :text
    add_column :sms_archives, :response_code, :string
    
    remove_column :messages, :TwilioResponse
  end
end
