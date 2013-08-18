class UpdateAttachedAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :attached, :string
    remove_column :attachments, :attachment
    
  end
end
