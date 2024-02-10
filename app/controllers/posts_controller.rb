class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def create
    @post = Post.new post_params

    if @post.save
      render :show, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.permit(:content)
  end
end
