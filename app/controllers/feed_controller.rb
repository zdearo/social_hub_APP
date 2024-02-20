class FeedController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all.joins(:user).order(created_at: :desc)
  end

end
