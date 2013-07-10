class CreateShareables < ActiveRecord::Migration
  def change
    create_table :shareables do |t|
      t.string :input
      t.string :shareable
      t.string :ref
      t.references :client, :null => false

      t.timestamps
    end
  end
end
