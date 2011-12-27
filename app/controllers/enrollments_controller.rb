class EnrollmentsController < ApplicationController
  
  def create
    @course = Course.find(params[:enrollment][:course_id])
    current_user.enroll!(@course)
    flash[:notice] = "Congratulations, your enrollment is complete."
    redirect_to @course
  end
  
  def destroy
    @course = Enrollment.find(params[:id]).course
    current_user.unenroll!(@course)
    flash[:notice] = "You have successfully removed yourself from this class."
    redirect_to @course
  end
  
end
