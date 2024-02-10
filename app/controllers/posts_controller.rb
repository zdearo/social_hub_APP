class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find params[:id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
