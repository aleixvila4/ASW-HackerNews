class SessionsController < ApplicationController
  
    def new
    @user = User.new
    render :login
    end
  
    def omniauth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to contributions_url
    end
    
    def logout
    session[:user_id] = nil
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
    end
  
    private
    
    def auth
    request.env['omniauth.auth']
    end
end