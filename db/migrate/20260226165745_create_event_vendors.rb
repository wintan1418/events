class CreateEventVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :event_vendors do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true

      t.decimal :contracted_amount, precision: 12, scale: 2, default: 0
      t.decimal :paid_amount, precision: 12, scale: 2, default: 0
      t.integer :status, default: 0, null: false
      t.text :notes
      t.date :service_date

      t.timestamps
    end

    add_index :event_vendors, [:event_id, :vendor_id], unique: true
    add_index :event_vendors, [:event_id, :status]
  end
end
