class SessionController < ApplicationController
  skip_before_action :authorize, only: [:index, :new, :create]

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:current_user_id] = user.id
        redirect_to user_path user
    else
        flash[:errors] = "Username (or) Password is WRONG"
        redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:errors] = "Log out is SUCCESS"
    redirect_to root_url
  end
end
