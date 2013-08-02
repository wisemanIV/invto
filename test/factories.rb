FactoryGirl.define do
  factory :message do
    body "a random message"
  end
  factory :sms_response do
    Body "a random message"
    AccountSid "233443434"
    From '+14154200068'
    SMSId "3434343535"
    To '+14154200068'
      
  end
  factory :client do
    domain "www.inv.to"
  end
  factory :client_number do
    phone '+14154200068'
  end

end