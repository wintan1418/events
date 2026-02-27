class CreateVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :vendors do |t|
      t.references :account, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.string :name, null: false
      t.string :slug, null: false
      t.integer :category, default: 0
      t.string :email
      t.string :phone
      t.string :website
      t.text :address
      t.text :notes
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :vendors, :slug, unique: true
    add_index :vendors, [:account_id, :category]
    add_index :vendors, [:account_id, :active]
  end
end
