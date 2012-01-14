class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super
    @user.facebook.feed!(
      :message => 'I just signed up for <a href = "Skillstruct.com">Skillstruct</a>', 
      :name => 'Skillstruct'
    )
  end
end
