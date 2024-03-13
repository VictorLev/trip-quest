class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
    @posts = Post.where(feed_id: params[:id]).order("created_at DESC")
    @post = Post.new
    @user = current_user
  end

  def index
    @feeds = Feed.all
  end

end
