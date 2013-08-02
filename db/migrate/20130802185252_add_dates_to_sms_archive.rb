class AddDatesToSmsArchive < ActiveRecord::Migration
  def change
    add_column :sms_archives, :entered_date, :datetime
    add_column :sms_archives, :processed_date, :datetime
  end
end
