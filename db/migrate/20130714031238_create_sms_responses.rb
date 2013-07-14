class CreateSmsResponses < ActiveRecord::Migration
  def change
    create_table :sms_responses do |t|
      t.string :SMSId
      t.string :AccountSid
      t.string :From
      t.string :To
      t.string :Body
      t.string :FromCity
      t.string :FromState
      t.string :FromZIP
      t.string :FromCountry
      t.string :ToCity
      t.string :ToState
      t.string :ToZIP
      t.string :ToCountry

      t.timestamps
    end
  end
end
