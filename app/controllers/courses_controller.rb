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
    if user_signed_in?
      @course = Course.new
    else
      redirect_to new_user_registration_path
    end
  end
  
  def create
    @course = Course.new(params[:course])
    @course.user_id = current_user.id
    current_user.teach!(@course, current_user)
    if @course.save
      flash[:notice] = "Course has been created."
      #current_user.twitter.update("Check out my new course on Skillstruct.")
      current_user.facebook.feed!(
        :message => 'I just created a new course on skillstruct', 
        :name => 'My Rails 3 App with Omniauth, Devise and FB_graph'
      )
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
    current_user.unteach!(@course, current_user)
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
    course_email = @course.paypal_email
    
    cost = @course.cost
    me = (cost)
    them = (cost*0.75)
    
    pay_request = PaypalAdaptive::Request.new
        data = {
          "returnUrl" => "http://empty-robot-8386.herokuapp.com/courses",
          "requestEnvelope" => {"errorLanguage" => "en_US"},
          "currencyCode" => "USD",
          "receiverList" =>
                  { "receiver" => [
                    {"email" => "zksher_1325804404_biz@gmail.com", "amount"=>me, "primary" => true}, 
                    {"email"=>course_email, "amount"=>them, "primary" => false}
                  ]},
          "cancelUrl" => "http://empty-robot-8386.herokuapp.com/",
          "actionType" => "PAY",
          "ipnNotificationUrl" => "http://empty-robot-8386.herokuapp.com/ipn-notification"
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
  
  def ipn
    ipn = PaypalAdaptive::IpnNotification.new
        ipn.send_back(request.raw_post)

        if ipn.verified?
          logger.info "IT WORKED"
        else
          logger.info "IT DIDNT WORK"
        end

        render nothing: true
  end
  
end
