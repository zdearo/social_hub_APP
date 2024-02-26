class LikesController < ApplicationController
  include LikeHelper

  before_action :find_post

  def create
    if liked?(@post)
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("#{helpers.dom_id(@post)}_likes", 
          partial: 'posts/like/counter', locals: { post: @post }),

          turbo_stream.replace("like_button_#{@post.id}",
          partial: 'posts/like/like', locals: { post: @post })
        ]
      end
    end
  end

  def destroy
    if !(liked?(@post))
      flash[:notice] = "Cannot unlike"
    else
      @like = find_like(@post)
      @like.destroy
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("#{helpers.dom_id(@post)}_likes", 
          partial: 'posts/like/counter', locals: { post: @post }),

          turbo_stream.replace("like_button_#{@post.id}",
          partial: 'posts/like/like', locals: { post: @post })
        ]
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
