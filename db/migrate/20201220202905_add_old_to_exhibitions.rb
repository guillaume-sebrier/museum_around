class AddOldToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :old, :boolean
  end
end
