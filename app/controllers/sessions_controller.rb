class SessionsController < ApplicationController
    before_action :logged_in_redirect, only: [:new,:create]

    def new

    end

    def create
        user = User.find_by(username: params[:session][:username])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Poprawnie zalogowano"
            redirect_to root_path
        else
            flash.now[:error] = "Nieprawidłowe hasło lub login"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Zostałeś poprawnie wylogowany"
        redirect_to login_path
    end

    private
    def logged_in_redirect
        if logged_in?
            flash[:error] = "Jesteś już zalogowany!"
            redirect_to root_path
        end
    end
end