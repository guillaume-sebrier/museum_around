class CreateExhibitions < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibitions do |t|
      t.string :title
      t.date :starting_date
      t.date :ending_date
      t.text :description
      t.integer :price
      t.string :category
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
