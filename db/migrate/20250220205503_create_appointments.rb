class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.timestamp :scheduled_at
      t.string :code
      t.integer :status
      t.integer :duration
      t.text :notes

      t.timestamps
    end
    add_index :appointments, :code, unique: true
  end
end
