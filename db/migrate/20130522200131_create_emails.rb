class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :template
      t.string :to
      t.string :from
      t.string :toname
      t.string :fromname
      t.string :ref

      t.timestamps
    end
  end
end
