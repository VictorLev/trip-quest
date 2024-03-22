class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
    @posts = Post.where(feed_id: params[:id]).order("created_at DESC")
    @post = Post.new
    users = User.all
    @users = users.sort_by { |user| user.total_rewards }.reverse
  
    @user = current_user
    @feeds = Feed.all
  end

  def index
    @feeds = Feed.all
  end

end
