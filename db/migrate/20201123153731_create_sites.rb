class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :opening_time
      t.string :closing_time

      t.timestamps
    end
  end
end
