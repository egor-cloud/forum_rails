class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :new, :create, :update]
  before_action :set_post, only: [:edit, :update, :upvote, :downvote]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.category_id = params[:category_id]
    if @post.save
      flash[:success] = "Your question was created successfully,
                         if it say you will receive a notification"
      redirect_to category_post_path(@post.category_id, @post.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "question successfully update"
      redirect_to category_post_path(@post.category_id, @post.id)
    else
      render 'edit'
    end
  end

  def upvote
    respond_to do |format|
      if @post.liked_by(current_user)
        format.html do
          flash[:success] = "successfully"
          redirect_to category_post_path(@post.category_id, @post.id)
        end
        format.js
      end
    end
  end

  def downvote
    respond_to do |format|
      if @post.downvote_from(current_user)
        format.html do
          flash[:success] = "successfully"
          redirect_to category_post_path(@post.category_id, @post.id)
        end
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:header, :body, :category_id, :all_tags)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
