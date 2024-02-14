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
    @post = Post.create!(post_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append('posts', @post)
      end

      format.html { redirect_to feed_index_path }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@post)
      end

      format.html
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
