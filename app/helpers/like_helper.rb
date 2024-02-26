module LikeHelper
  
  def liked?(post)
    Like.where(user_id: current_user.id, post_id: post.id).exists?
  end

  def like_button(post) 
    if liked?(post)
      link_to "Unlike", post_like_path(post, find_like(post)), data: {:turbo_method => :delete}, id: "like_button_#{post.id}"
    else 
      link_to "Like", post_likes_path(post), data: {:turbo_method => :post}, id: "like_button_#{post.id}"
    end 
  end
    
  def like_users(post) 
    User.joins(:likes).where(likes: { post_id: post.id }) 
  end

  def find_like(post)
    Like.find_by(user_id: current_user.id, post_id: post.id)
  end

end
