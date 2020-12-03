class AddFakeToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :fake, :boolean, default: false
  end
end
