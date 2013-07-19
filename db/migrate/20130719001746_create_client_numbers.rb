class CreateClientNumbers < ActiveRecord::Migration
  def change
    create_table :client_numbers do |t|
      t.integer :client_id
      t.string :phone

      t.timestamps
    end
  end
end
