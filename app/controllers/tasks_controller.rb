class TasksController < ApplicationController

    before_action :authenticate_user

    def new
      @task = Task.new
    end

    def index
      if current_user.is_admin?
        @tasks = Task.all
      else
        @tasks = Task.all.where(user_id: current_user.id)
      end
    end

    def edit
      @task = Task.find(params[:id])
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      flash[:success] = "Tarefa foi deletada com sucesso"
      redirect_to root_path
    end

    def show
      @task = Task.find(params[:id])
    end

    def create
      @task = Task.new(task_params)

      if @task.save
        flash[:success] = "Tarefa criada com sucesso"
        redirect_to root_path
      else
        render 'new'
      end
    end

    def update
      @task = Task.find(params[:id])
      if @task.update_attributes(task_params)
        flash[:success] = "Tarefa editada com sucesso"
        redirect_to tasks_path
      else
        render 'edit'
      end
    end

    def assign_task
      @task = Task.find(params[:id])
    end

    def assign_task_to_someone
      @user = User.find_by(name: params[:name])
      @task = Task.find(params[:id])
      @task.user_id = @user.id
      @task.save
      redirect_to root_path
    end

    def set_task_status
      redirect_to root_path unless request.xhr?
      updated = false
      @task = Task.find_by_id params[:id]

      if @task
        @task.status = params[:status] unless params[:status].nil?
        if params[:status] == "100"
          @task.closed = true
          @user = @task.user
          @user.tasks_done += 1
          @user.save
        end
        @task.save
        updated = true
      end

      render json: updated
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :user_id, :status)
    end
end
