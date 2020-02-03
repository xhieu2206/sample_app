class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Tự động đăng nhập cho user mới đăng ký tài khoản
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to Sample App"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle successful update
      flash[:success] = "Update successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # def search
  #   if params[:search].present?
  #     search = User.search do
  #       fulltext params[:search]
  #     end
  #     # debugger
  #     @users = search.results
  #   end
  # end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirm a logged in user
    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = "Please login first"
        redirect_to login_path
      end
    end

    # Confirm the edit or uodate user is owner of current user
    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:danger] = "You don't have this permission"
        redirect_to root_path
      end
    end

    # Prevent a non-admin user can delete another user
    def admin_user
      redirect_to(root_path) unless current_user.admin? && current_user != User.find(params[:id])
    end

end
