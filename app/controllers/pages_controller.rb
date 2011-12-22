class PagesController < ApplicationController
  def home
    @title = "Home"
    if user_signed_in?
    @feed_items = current_user.feed
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
end
