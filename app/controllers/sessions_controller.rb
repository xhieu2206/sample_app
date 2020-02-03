class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Handle user login
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = "Invalid email/password"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end
end
