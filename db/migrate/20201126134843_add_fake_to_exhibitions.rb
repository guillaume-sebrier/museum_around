class AddFakeToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :fake, :boolean, default: true
  end
end
