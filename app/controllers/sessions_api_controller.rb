class SessionsApiController < ApplicationController
    before_action :authenticate, except: [ :index]
    
    def show_sessions
        @usuario = User.where(id: params[:id])
        authenticate()
        if @flag == 0
          if @usuario[0] == nil
            render :json => {"Error": "User not found"}.to_json, status: 404
          else
            render json: @usuario[0], status: 200 
          end
        end
    end
  
    def update_sessions
        @usuario = User.where(id: params[:id])
        authenticate()
        if @flag == 0
          if @usuario[0].id != @user[0].id
            render :json => {"Error": "Unauthorized user"}.to_json, status: 401
          elsif @usuario[0] == nil
            render :json => {"Error": "User not found"}.to_json, status: 404
          else
            @usuario.update(user_params_api)
                render json: @usuario[0], status: 200   
          end
        end
    end
  
    def user_params_api
      params.require(:user).permit(:username, :Karma, :email, :about)
    end
  
  
    
end
