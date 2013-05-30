class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :to
      t.string :from
      t.string :toname
      t.string :fromname
      t.string :ref
      t.references :client, :null => false
      t.references :email_template, :null => false

      t.timestamps
    end
  end
end
