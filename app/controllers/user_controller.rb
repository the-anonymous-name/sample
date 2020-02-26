class UserController < ApplicationController
    skip_before_action :authorize, only: [:index, :new, :create]

    def new
      @user = User.new
    end

    def create
      @user = User.new(params.require(:user).permit(:username,:password,:email,:phone))
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def show
      @user = User.find(params[:id])
    end
end
