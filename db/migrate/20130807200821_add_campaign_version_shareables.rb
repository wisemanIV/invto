class AddCampaignVersionShareables < ActiveRecord::Migration
  def up
    add_column :shareables, :campaign, :string
    add_column :shareables, :version, :string
    remove_column :shareables, :input
  end

  def down
  end
end
