class UsersApiController < ApplicationController
    #before_action :authenticate
    
    def showUserIDAPI
        @usuari = User.where(id: params[:id])
        @user = User.where(auth_token: request.headers['ApiKeyAuth'])
        if @usuari[0] == nil
          render :json => {"Error": "User not found"}.to_json, status: 404
        end
        if @usuari[0].id == @user[0].id
          render json: @usuari[0]
        else 
          render_user(@usuari[0], 200)
        end
    end
    
    def showUserUsernameAPI
        @usuari = User.where(username: params[:username])
        @user = User.where(auth_token: request.headers['ApiKeyAuth'])
        if @usuari[0] == nil
          render :json => {"Error": "User not found"}.to_json, status: 404
        end
        if @usuari[0].id == @user[0].id
          render json: @usuari[0]
        else 
          render_user(@usuari[0], 200)
        end
    end
  
    def updateUserAPI
      @usuari = User.where(id: params[:id])
      @user = User.where(auth_token: request.headers['ApiKeyAuth'])
      if @usuari[0] == nil
        render :json => {"Error": "User not found"}.to_json, status: 404
      elsif @usuari[0].id != @user[0].id
        render :json => {"Error": "Unauthorized user"}.to_json, status: 401
      else
        @usuari[0].update(user_params_api)
        render json: @usuari[0]
      end
    end
    
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params_api
      params.require(:users_api).permit(:username, :Karma, :email, :about)
    end
    
    def render_user(user, status)
      render :json => {
          id: user.id,
          name: user.username,
          karma: user.Karma,
          email: user.email,
          about: user.about,
          created_at: user.created_at
        }.to_json, status: status
    end
  
    
end
