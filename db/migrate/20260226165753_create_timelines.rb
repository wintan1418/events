class CreateTimelines < ActiveRecord::Migration[8.0]
  def change
    create_table :timelines do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.time :start_time, null: false
      t.time :end_time
      t.string :title, null: false
      t.text :description
      t.string :responsible_party
      t.string :location
      t.integer :position

      t.timestamps
    end

    add_index :timelines, [:event_id, :start_time]
    add_index :timelines, [:event_id, :position]
  end
end
