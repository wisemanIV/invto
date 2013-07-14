class AddUserIdToSmsResponse < ActiveRecord::Migration
  def change
    add_column :sms_responses, :user_id, :integer 
  end
end
