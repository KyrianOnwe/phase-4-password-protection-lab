class UsersController < ApplicationController
    wrap_parameters format: []
    def create 
        if params[:password_confirmation] == params[:password]
            user = User.create(user_params)        
            session[:user_id] = user.id
            render json: user
        else 
            render json: {error: "Passwords do not match"}, status: :unprocessable_entity
        end

    end

    def show
         user =  User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "No user is logged in" }, status: :unauthorized
        end

    end

    private

    def user_params
        params.permit(:username, :password)
    end

end
