class AddUserAgentClicks < ActiveRecord::Migration
  def up
    add_column :clicks, :user_agent, :text
  end

  def down
  end
end
