class StaticPagesController < ApplicationController
  def home
    # debugger
    unless !logged_in?
      @micropost = current_user.microposts.build
      @feed_microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
