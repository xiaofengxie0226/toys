class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include UserSession

    private
    def auth_user
      unless session[:user_id]
        flash[:notice] = "Please login"
        redirect_to new_session_path
      end
    end
end
