class SmsArchive < ActiveRecord::Base
  attr_accessible :campaign, :body, :from, :sms_id, :status, :to, :version, :processed_date, :entered_date
end
