module ApplicationHelper
  def title
      base_title = "Subscripty"
      if @title.nil?
        base_title
      else
        "#{base_title} | #{@title}"
      end
    end
    
    def logo
         image_tag("rails.png", :alt => "Subscripty", :class => "round")
    end
end
