class AddClosedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :closed, :boolean
  end
end
