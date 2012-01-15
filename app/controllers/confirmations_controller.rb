class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super
      @user.facebook.feed!(
        :message => 'I just signed up for Skillstruct.com', 
        :name => 'Skillstruct'
      )
      @user.twitter.update("My Rails 3 App with Omniauth, Devise and Twitter")  
    else
      
    end
  end
end
