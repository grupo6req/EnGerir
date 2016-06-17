class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :description
      t.text :areas_worked
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.integer :tasks_done, default: 0

      t.timestamps null: false
    end
  end
end
