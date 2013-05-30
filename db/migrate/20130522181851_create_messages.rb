class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to
      t.string :body
      t.string :from
      t.string :ref
      t.references :client, :null => false

      t.timestamps
    end
  end
end
