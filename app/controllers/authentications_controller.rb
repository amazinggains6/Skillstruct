class AuthenticationsController < ApplicationController
  
  def create
    render :text => request.env["omniauth.auth"].to_yaml
  end
  
  def index
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
