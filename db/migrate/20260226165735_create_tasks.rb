class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :assigned_to, null: true, foreign_key: { to_table: :users }
      t.references :created_by, null: true, foreign_key: { to_table: :users }

      t.string :title, null: false
      t.text :description
      t.date :due_date
      t.integer :status, default: 0, null: false
      t.integer :priority, default: 1, null: false
      t.integer :position

      t.timestamps
    end

    add_index :tasks, [:event_id, :status]
    add_index :tasks, [:assigned_to_id, :status]
    add_index :tasks, [:event_id, :due_date]
    add_index :tasks, [:event_id, :position]
  end
end
