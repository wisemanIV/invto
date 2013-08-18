class AddAttachmentMessages < ActiveRecord::Migration
  def change
    add_column :messages, :attachment_id, :integer
    remove_column :messages, :attachment
  end
end
