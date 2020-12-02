module SessionsHelper
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def authenticate
        @user = User.where(auth_token: request.headers['ApiKeyAuth'])
        if @user[0] == nil
            render :json => {"Error": "Unauthorized user"}.to_json, status: 401
        end
    end

end