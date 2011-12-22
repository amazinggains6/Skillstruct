class UsersController < ApplicationController
  
  before_filter :find_user
  
  def show
    @title = @user.id
  end
  
  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The user you were looking" +
      " for could not be found."
      redirect_to root_path
  end
  
  def following
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
  end
  
  def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers
      render 'show_follow'
  end
  
end
