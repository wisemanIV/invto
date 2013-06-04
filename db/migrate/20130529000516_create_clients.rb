class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :title
      t.string :contactemail
      t.string :urlscheme
      t.string :defaulturl
      t.string :domain
      
      t.references :user, :null => false

      t.timestamps
    end
  end
end
