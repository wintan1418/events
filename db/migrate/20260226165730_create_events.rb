class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :account, null: false, foreign_key: true
      t.references :planner, null: true, foreign_key: { to_table: :users }
      t.references :client, null: true, foreign_key: { to_table: :users }

      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.integer :event_type, default: 0
      t.date :event_date
      t.time :start_time
      t.time :end_time
      t.string :venue
      t.text :venue_address
      t.integer :status, default: 0, null: false
      t.decimal :budget_total, precision: 12, scale: 2, default: 0
      t.integer :estimated_guests, default: 0
      t.text :notes

      t.timestamps
    end

    add_index :events, :slug, unique: true
    add_index :events, [:account_id, :status]
    add_index :events, [:account_id, :event_date]
  end
end
