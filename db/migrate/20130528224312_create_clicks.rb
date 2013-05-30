class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.string :targeturl
      t.string :defaulturl
      t.string :device
      t.string :browser
      t.string :actualurl
      t.string :ref
      t.references :client, :null => false

      t.timestamps
    end
  end
end
