class CoursesController < ApplicationController
  include ApplicationHelper

  def index
    state = params[:state]
    if (params[:state])
      @courses = Course.where(:state => state)
    elsif current_user
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
  
  def purchase
    @course = Course.find(params[:id])
    @user = current_user
  end 
 
  def enroll
    @course = Course.find(params[:id])
    @user = current_user
    paypal_email = params[:paypal_email]
    
    pay_request = PaypalAdaptive::Request.new
        data = {
          "returnUrl" => "http://empty-robot-8386.herokuapp.com/",
          "requestEnvelope" => {"errorLanguage" => "en_US"},
          "currencyCode" => "USD",
          "receiverList" =>
                  { "receiver" => [
                    {"email" => "zksher_1325804404_biz@gmail.com", "amount"=>"10.00"}
                  ]},
          "cancelUrl" => "http://empty-robot-8386.herokuapp.com/courses",
          "actionType" => "PAY",
          "ipnNotificationUrl" => "ipn_url"
        }

        #To do chained payments, just add a primary boolean flag:{“receiver”=> [{"email"=>"PRIMARY", "amount"=>"100.00", "primary" => true}, {"email"=>"OTHER", "amount"=>"75.00", "primary" => false}]}

        pay_response = pay_request.pay(data)

        if pay_response.success?
            # Send user to paypal
            redirect_to pay_response.approve_paypal_payment_url
        else
            puts pay_response.errors.first['message']
            redirect_to "/", notice: "Something went wrong. Please contact support."
        end
  end
  
end
