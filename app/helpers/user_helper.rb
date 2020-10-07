module UserHelper
  def your_question
    current_user.posts.order("created_at DESC")
  end
end
