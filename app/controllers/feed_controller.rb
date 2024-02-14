class FeedController < ApplicationController

  def index
    @posts = Post.all
  end

end
