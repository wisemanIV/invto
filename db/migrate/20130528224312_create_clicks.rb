class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.string :targeturl
      t.string :defaulturl
      t.string :client
      t.string :ref
      t.string :device
      t.string :browser
      t.string :actualurl

      t.timestamps
    end
  end
end
