class AddColToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :website, :string
    add_column :sites, :wiki_link, :string
    add_column :sites, :phone, :string
  end
end
