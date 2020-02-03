class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirm a logged in user
    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = "Please login first"
        redirect_to login_path
      end
    end
end
