class PostsController < ApplicationController
  def create
    @feed = Feed.find(params[:feed_id])
    @post = Post.new(post_params)
    @post.feed = @feed
    @post.user = current_user
    if @post.save
      FeedChannel.broadcast_to(
        @feed,
        render_to_string(partial: "post", locals: {post: @post})
      )
      head :ok
    else
      render "feeds/show", status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
