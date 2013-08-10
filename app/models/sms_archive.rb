class SmsArchive < ActiveRecord::Base
  include FormatterModule
  attr_accessible :campaign, :body, :from, :sms_id, :status, :to, :version, :processed_date, :entered_date, :response, :response_code, :user_id, :client_id
end
