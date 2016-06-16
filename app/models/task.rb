class Task < ActiveRecord::Base
  belongs_to :user

  def close_task
  	self.closed = true
  	current_user.tasks_done +=1
  	current_user.save
  	self.save
  end
end
