class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build unless !logged_in?
    @feed_microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
  end

  def help
  end

  def about
  end

  def contact
  end
end
