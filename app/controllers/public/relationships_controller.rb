class Public::RelationshipsController < ApplicationController
  #followするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  #followを外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  #follow一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  #follower一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
