class ToysController < ApplicationController
    before_action :auth_user, except: [:index, :show]
  
    def index
      @toys = Toy.page(params[:page] || 1).per_page(params[:per_page] || 10).
        order("id desc").where(is_public: true).includes(:tags,:user)
    end
  
    def new
      @toy = Toy.new
    end
  
    def create
      @toy = current_user.toys.new(toy_attrs)
      if @toy.save
        flash[:notice] = "success"
        redirect_to toys_path
      else
        flash[:notice] = "failed"
        render action: :new
      end
    end
  
    def show
      @toy = Toy.find params[:id]
    end
  
    def edit
      @toy = current_user.toys.find params[:id]
      render action: :new
    end
  
    def update
      @toy = current_user.toys.find params[:id]
      @toy.attributes = toy_attrs
      if @toy.save
        @toy.tags.destroy_all
  
        flash[:notice] = "update success"
        redirect_to toys_path
      else
        flash[:notice] = "update failed"
        render action: :new
      end
    end

    def destroy
      @toy = current_user.toys.find params[:id]
      if @toy.destroy
        flash[:notice] = "delete success"
        redirect_to toys_path
      else
        flash[:notice] = "delete failed"
        render action: :new
      end
    end
  
    private
    def toy_attrs
      params.require(:toy).permit(:toyname, :description, :is_public,:url,:tags_string)
    end
end
