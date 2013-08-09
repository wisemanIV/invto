FactoryGirl.define do
  factory :message do
    body "a random message"
    from "14154200068"
    to "4154200068"
    status "processing"
    campaign "test"
    version "1.2"
    SmsId "34354545454"
    TwilioResponse "working"
  end
  factory :sms_response do
    Body "a random message"
    AccountSid "233443434"
    From '+14155039151'
    SMSId "3434343535"
    To '+14155039151'
  end
  factory :recording do
    tag "A new messages for you"
    url "http://www.inv.to/3434343asass3/334343434.mp3"
  end
  factory :client do
    domain "www.inv.to"
    title "a test"
    contactemail { Faker::Internet.email }
    defaulturl "http://www.wikipedia.com"
    default_android_url "http://www.google.com"
    android_scheme "//"
    default_ios_url "http://www.apple.com"
    ios_scheme "//"
  end
  factory :client_number do
    phone '+14155039151'
  end
  factory :user do
    password "foobar1234"
    password_confirmation { |u| u.password }
    email { Faker::Internet.email }
  end
  factory :click do
    actualurl "http://www.google.com"
    browser "chrome"
    defaulturl "http://www.bbc.com"
    device "mac"
    targeturl "http://www.yahoo.com"
  end
  factory :shareable do
    campaign "Test campaign"
    version "1.0.0"
    shareable "http://inv.to/abc876"
    destination "http://www.amazon.com"
    short "abc876"
  end
  factory :recipient do
    CountryCode "+1"
    OptOut true
    Phone "4154200069"
  end

end