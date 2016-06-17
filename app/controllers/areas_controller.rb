class AreasController < ApplicationController

    before_action :authenticate_user

    def new
      @area = Area.new
    end

    def index
      @areas = Area.all
    end

    def edit
      @area = Area.find(params[:id])
    end

    def destroy
      @area = Area.find(params[:id])
      @area.destroy
      flash[:success] = "A área foi criada com sucesso"
      redirect_to areas_path
    end

    def show
      @area = Area.find(params[:id])
    end

    def create
      @area = Area.new(area_params)

      if @area.save
        flash[:success] = "Área criada com sucesso"
        redirect_to areas_path
      else
        render 'new'
      end
    end

    def update
      @area = Area.find(params[:id])
      if @area.update_attributes(area_params)
        flash[:success] = "Área editada com sucesso"
      else
        render 'edit'
      end
    end

    private

    def area_params
      params.require(:area).permit(:name, :description)
    end
end
