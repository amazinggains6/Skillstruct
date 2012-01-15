class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super
    @authentications = @user.authentications
    @authentications.each do |authentication|
      if authentication.provider == "facebook"
        @user.facebook.feed!(
          :message => 'I just signed up for Skillstruct.com', 
          :name => 'Skillstruct'
          )
      elsif authentication.provider == "twitter"
        @user.twitter.update("My Rails 3 App with Omniauth, Devise and Twitter")
      else
    end 
   end 
  end
end
