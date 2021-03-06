class UsersController < ApplicationController

    before_action :authenticate_user, except: [:new, :create]

    def new
      @user = User.new
    end

    def index
      @users = User.all
    end

    def edit
      @user = User.find(params[:id])
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "Usuário foi deletado com sucesso"
      redirect_to users_path
    end

    def show
      @tasks = User.find(params[:id]).tasks
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)

      if @user.save
        log_in @user
        flash[:success] = "Usuário criado com sucesso"
        redirect_to root_path
      else
        render 'new'
      end
    end

    def update
      @user = User.find(params[:id])
      @area = if (not params[:user][:area].nil?) and (not params[:user][:area].empty?)
                Area.find(params[:user][:area])
              else
                nil
              end

      if @user.update_attributes(user_params)
        @user.area = @area
        @user.save
        flash[:success] = "Usuário editado com sucesso"
        redirect_to @user
      else
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :description, :areas_worked, :password, :password_digest, :password_confirmation)
    end
end
