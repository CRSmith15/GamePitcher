class SessionsController < ApplicationController 
    def home 
    end

    def new 
    end

    def create 
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else
            flash[:message] = "Wrong login info. Try again."
            redirect_to '/login'
        end

    end

    def googlelogin
        @user = User.find_or_create_by(email: auth["info"]["email"]) do |u|
            u.username = auth["info"]["first_name"]
            u.password = SecureRandom.hex(12)
        end
        if @user.save 
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to '/'
        end

    end


    def destroy 
        session.clear 
        redirect_to '/'
    end

    private 

    def auth 
        request.env['omniauth.auth']
    end



end
