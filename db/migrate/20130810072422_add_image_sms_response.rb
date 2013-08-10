class AddImageSmsResponse < ActiveRecord::Migration
  def up
    add_column :sms_responses, :image_url, :text
  end

  def down
  end
end
