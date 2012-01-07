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
#pay_response is failing right now 
        if pay_response.success?
            # Send user to paypal
            redirect_to pay_response.approve_paypal_payment_url
        else
            puts pay_response.errors.first['message']
            redirect_to "/", notice: "Something went wrong. Please contact support."
        end
    
    
  end
  
  def show
    @purchase = Purchase.find(params[:id])
  end
    
  
end
