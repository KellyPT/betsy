module ApplicationHelper

  def render_date(date)
    ("<span class='date'>" + date.strftime("%A, %b %d %Y") +  "</span>").html_safe
  end

end
