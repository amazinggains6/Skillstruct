class UsersController < ApplicationController
  
  before_filter :find_user, :except => [:dashboard]
  
  def show
    @title = @user.id
    @enrollments = @user.enrollments
    @courses = Course.find(:all, :conditions => [ "user_id IN (?)", @user.id], :limit => 50)
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
  
  def dashboard
    @title = "Dashboard"
    if user_signed_in?
    @feed_items = current_user.feed
    end
    @enrollments = current_user.enrollments
    @user = current_user
    @courses = Course.find(:all, :conditions => [ "user_id IN (?)", current_user.id], :limit => 50)
  end
  
end

