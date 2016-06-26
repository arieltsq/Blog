class SessionsController < ApplicationController
  def new
  end

  def create
    # storing the sessions
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to home_path, notice: "Logged In"
    else
      flash.now.alert = "Couldn't sign you in. Please check your email and password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:notice] = 'Signed out'
    # render "new"
    redirect_to home_path

  
  end

end
