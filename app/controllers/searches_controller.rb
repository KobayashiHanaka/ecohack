class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render "/public/users/index"
    else
      @posts = Post.looks(params[:search], params[:word])
      @post = Post.new
      render "/public/posts/index"
    end
    
  end



end
