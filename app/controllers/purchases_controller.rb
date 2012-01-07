class PurchasesController < ApplicationController
  
  def new
     @course = Course.find(params[:course_id])
     @purchase = @course.purchases.build
  end
  
  def create
    @course = Course.find(params[:course_id])
    @purchase = @course.purchases.build(params[:purchase])
    @user = current_user
    course_email = @course.paypal_email
    
    @purchase.save
    redirect_to [@course, @purchase]
  end
  
  def show
    @purchase = Purchase.find(params[:id])
  end
    
  
end
