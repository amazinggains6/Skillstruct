class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super
      @user.facebook.feed!(
        :message => 'I just signed up for Skillstruct.com', 
        :name => 'Skillstruct'
      )
       
    else
      
    end
  end
end
