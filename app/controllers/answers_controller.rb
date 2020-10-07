class AnswersController < ApplicationController
  before_action do |controller|
    unless controller.send(:logged_in_user)
    end
  end
  before_action :get_user, only: :create
  before_action :get_post, only: [:create, :destroy]
  before_action :get_category, only: [:create, :destroy]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id, @answer.post_id = get_user, get_post
    if @answer.save
      #Сделать пуш уведомление для пользователя
      flash[:success] = "Response created successfully"
      redirect_to category_post_path(get_category, get_post)
    else
      render 'new'
    end
  end

  def destroy
    Answer.find(params[:id]).destroy
    flash[:success] = "Your answer deleted"
    redirect_to category_post_path(get_category, get_post)
  end

  def upvote
    @answer = Answer.find(params[:answer_id])
    respond_to do |format|
      if @answer.liked_by(current_user)
        format.html do
          flash[:success] = "successfully"
          redirect_to category_post_path(paramas[:category_id], params[:id])
        end
        format.js
      end
    end
  end

  def downvote
    @answer = Answer.find(params[:answer_id])
    respond_to do |format|
      if @answer.downvote_from(current_user)
        format.html do
          flash[:success] = "successfully"
          redirect_to category_post_path(paramas[:category_id], params[:id])
        end
        format.js
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def get_user
    current_user.id
  end

  def get_post
    params[:post_id]
  end

  def get_category
    params[:category_id]
  end
end
