class CreateCommunityFeeds < ActiveRecord::Migration
  def change
    create_table :community_feeds do |t|

      t.timestamps
    end
  end
end
