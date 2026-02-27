class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :subdomain, null: false
      t.string :slug, null: false
      t.integer :plan_type, default: 0, null: false
      t.string :phone
      t.string :email
      t.string :website
      t.text :address
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :accounts, :subdomain, unique: true
    add_index :accounts, :slug, unique: true
    add_index :accounts, :active
  end
end
