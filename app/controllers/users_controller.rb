class UsersController < ApplicationController
    before_action :auth_user,only: [:index]

     def index
       @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10)
         .order("id desc")
     end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_attrs)
      if @user.save
        flash[:notice] = "signup succeed! Please Login"
        redirect_to new_session_path
      else
        render action: :new
      end
    end
  
    def toys
      @toys = current_user.toys.page(params[:page] || 1).per_page(params[:per_page] || 10).
      order("id desc").includes(:tags,:user)
    end
  
    def user_attrs
      params.require(:user).permit(:username, :password,:password_confirmation,:email)
    end
end
