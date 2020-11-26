class AddPhotoToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :photo, :string
    add_column :exhibitions, :place, :string
    add_column :exhibitions, :date, :string
  end
end
