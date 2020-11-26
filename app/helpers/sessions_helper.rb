module SessionsHelper
    
    def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def authenticate
        @user = User.where(auth_token: request.headers['token'])
        @flag = 0
        if @user[0] == nil
          render :json => {"Error": "Unauthorized user"}.to_json, status: 401
          @flag = 1
        end
    end

end