class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.authenticate(params[:username], params[:password])
      if @user
        signin_user @user
        
        render json: {
          status: 'ok',
          msg: {
            redirect_url: root_path
          }
        }
      else
        render json: {
          status: 'error',
          msg: "Incorrect username or password "
        }
      end
    end
  
    def destroy
      logout_user
      flash[:notice] = "logout"
      redirect_to root_path
    end
end
