class EnrollmentsController < ApplicationController
  
  def create
    @course = Course.find(params[:enrollment][:course_id])
    enrollments = @course.enrollments.count  
      if enrollments < @course.attendance
        current_user.enroll!(@course, current_user)
        flash[:notice] = "Congratulations, your enrollment is complete."
        redirect_to @course
      else
        flash[:notice] = "Sorry, this class is full."
        redirect_to @course
      end
  end
  
  def destroy
    @course = Enrollment.find(params[:id]).course
    current_user.unenroll!(@course)
    flash[:notice] = "You have successfully removed yourself from this class."
    redirect_to @course
  end
  
end
