class AddAttachmentSmsResponse < ActiveRecord::Migration
  def up
    remove_column :sms_responses, :image_url
    
    add_column :sms_responses, :attachment, :string
  end

  def down
  end
end
