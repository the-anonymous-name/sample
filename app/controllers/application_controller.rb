class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    User.find_by(id: session[:current_user_id])
  end

  def authorize
     redirect_to root_url, flash: {errors: "Sign in (or) Sign up to PROCEED"} unless current_user
  end
end
