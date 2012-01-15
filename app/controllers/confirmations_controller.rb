class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super
    @authentications = @user.authentications
    @authentications.each do |authentication|
      if authentication.provider == "facebook"
        @user.facebook.feed!(
          :message => 'I just signed up for http://Skillstruct.com/', 
          :name => 'Skillstruct'
          )
      elsif authentication.provider == "twitter"
        @user.twitter.update("I just signed up for http://Skillstruct.com/")
      else
    end 
   end 
  end
end
