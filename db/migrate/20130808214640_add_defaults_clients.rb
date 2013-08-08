class AddDefaultsClients < ActiveRecord::Migration
  def up
    add_column :clients, :default_android_url, :text
    add_column :clients, :default_ios_url, :text
    add_column :clients, :android_scheme, :string
    add_column :clients, :ios_scheme, :string
    
    remove_column :clients, :urlscheme
  end

  def down
  end
end
