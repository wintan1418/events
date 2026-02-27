class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :event_vendor, null: true, foreign_key: true

      t.string :category, null: false
      t.string :description, null: false
      t.decimal :estimated_cost, precision: 12, scale: 2, default: 0
      t.decimal :actual_cost, precision: 12, scale: 2, default: 0
      t.boolean :paid, default: false, null: false
      t.text :notes

      t.timestamps
    end

    add_index :line_items, [:event_id, :category]
    add_index :line_items, [:event_id, :paid]
  end
end
