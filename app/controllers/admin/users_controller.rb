class Admin::UsersController < ApplicationController
  def index
    @users= User.all
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
  end

 private

 def user_params
  params.require(:user).permit(:name,:email,:password,:introduce,:profile_image)
 end

end
