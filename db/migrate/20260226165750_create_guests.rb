class CreateGuests < ActiveRecord::Migration[8.0]
  def change
    create_table :guests do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :phone
      t.integer :rsvp_status, default: 0, null: false
      t.text :dietary_notes
      t.integer :table_number
      t.integer :party_size, default: 1
      t.string :meal_choice
      t.text :notes

      t.timestamps
    end

    add_index :guests, [:event_id, :rsvp_status]
    add_index :guests, [:event_id, :table_number]
    add_index :guests, [:event_id, :email]
  end
end
