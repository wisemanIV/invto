class Attachment < ActiveRecord::Base
  attr_accessible :attached, :remote_attached_url, :attachment_attributes
  mount_uploader :attached, AttachmentUploader
end
