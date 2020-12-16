class AddLinkToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :link, :string
    add_column :exhibitions, :detailed_desc, :text
  end
end
