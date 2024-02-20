class LikeController < ApplicationController
  def create
    @like = Like.new
    @like.user_id = current_user.id
    @like.post_id = params[:post_id]
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
