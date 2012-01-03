class CoursesController < ApplicationController
  include ApplicationHelper

  def index
    state = params[:state]
    if (params[:state])
      @courses = Course.where(:state => state)
    elsif current_user.state?
      @courses = Course.where(:state => current_user.state)
    else
      @courses = Course.all
    end
  end
  
  def show
    @course = Course.find(params[:id])
    @user = @course.user
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(params[:course])
    @course.user_id = current_user.id
    current_user.teach!(@course, current_user)
    if @course.save
      flash[:notice] = "Course has been created."
      redirect_to @course
    else
      flash[:alert] = "Course has not been created."
      render :action => "new"
    end
  end
  
  def edit
    @course = Course.find(params[:id])
  end
  
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = "Course has been updated."
      redirect_to @course
    else
      flash[:alert] = "Course has not been updated."
      render :action => "edit"
    end
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Course has been deleted."
    redirect_to courses_path
  end
 
  
end
