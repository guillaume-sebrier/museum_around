class AddPictureToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :picture, :string
  end
end
