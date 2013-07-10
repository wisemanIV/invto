class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to
      t.string :body
      t.string :from
      t.string :campaign
      t.string :version
      t.string :status, :default => 'initial'
      t.references :user, :null => false

      t.timestamps
    end
  end
end
