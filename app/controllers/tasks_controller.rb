class TasksController < ApplicationController

    before_action :authenticate_user

    def new
      @task = Task.new
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

    private

    def task_params
      params.require(:task).permit(:name, :description)
    end
end
