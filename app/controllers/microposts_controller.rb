class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Create micropost successfully"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy

  end

  def search_for_micropost
    debugger
    @search = Sunspot.search Micropost do
      fulltext params[:q]
      with :user_id, 5
    end
    debugger
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
