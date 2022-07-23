class Public::PostsController < ApplicationController
  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post2 = Post.find_by(params[:post_id])
    @newpost = Post.new
    @comment = PostComment.new
  end

  def create
    @posts = Post.all
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path(@post.id)
    else
      render :index
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
    @post.update
    redirect_to post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:title,:sentence,:post_image,:user_id)
  end
end
