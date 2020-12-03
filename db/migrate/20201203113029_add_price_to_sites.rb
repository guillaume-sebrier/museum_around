class AddPriceToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :price, :integer
  end
end
