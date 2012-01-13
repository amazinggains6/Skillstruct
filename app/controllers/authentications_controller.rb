class AuthenticationsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to authentications_url
  end
  
  def index
    @authentications = Authentication.all
  end
  
  def update
    
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
  
end
