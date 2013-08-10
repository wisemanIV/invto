class AddMogreetCampaignClient < ActiveRecord::Migration
  def up
    add_column :clients, :mogreet_campaign_id, :string
  end

  def down
  end
end
