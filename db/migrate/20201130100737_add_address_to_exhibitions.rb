class AddAddressToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :address, :string
  end
end
