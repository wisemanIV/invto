class CreateShareables < ActiveRecord::Migration
  def change
    create_table :shareables do |t|
      t.string :input
      t.string :shareable
      t.integer :client_id
      t.string :ref

      t.timestamps
    end
  end
end
