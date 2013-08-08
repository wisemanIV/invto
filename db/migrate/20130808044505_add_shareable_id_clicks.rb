class AddShareableIdClicks < ActiveRecord::Migration
  def up
    add_column :clicks, :shareable_id, :integer
    add_column :shareables, :short, :string
    remove_column :clicks, :ref
  end

  def down
  end
end
