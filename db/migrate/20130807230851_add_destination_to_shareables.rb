class AddDestinationToShareables < ActiveRecord::Migration
  def change
    add_column :shareables, :destination, :text
    remove_column :shareables, :ref
  end
end
