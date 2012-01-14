class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    @user.facebook.feed!(
      :message => 'I just signed up for <a href = "Skillstruct.com">Skillstruct</a>', 
      :name => 'Skillstruct'
    )
    session[:omniauth] = nil unless @user.new_record?
  end
  
  
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
