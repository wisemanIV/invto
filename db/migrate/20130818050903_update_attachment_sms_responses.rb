class UpdateAttachmentSmsResponses < ActiveRecord::Migration
  def change
    add_column :sms_responses, :attach, :string
    remove_column :sms_responses, :attachment
  end
end
