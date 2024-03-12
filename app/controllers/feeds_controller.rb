class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
    @post = Post.new
  end

  def index
    @feeds = Feed.all
  end

end
