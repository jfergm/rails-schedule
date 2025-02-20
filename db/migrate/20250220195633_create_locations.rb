class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :state
      t.text :notes

      t.timestamps
    end
  end
end
