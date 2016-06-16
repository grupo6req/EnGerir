class TasksController < ApplicationController

    before_action :authenticate_user

    def new
      @task = Task.new
    end

    def index
      @tasks = Task.all
    end

    def edit
      @task = Task.find(params[:id])
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      flash[:success] = "Tarefa foi deletada com sucesso"
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

    private

    def task_params
      params.require(:task).permit(:name, :description, :user_id)
    end
end
