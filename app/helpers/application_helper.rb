module ApplicationHelper
  def user_name
    begin
      user = Merchant.find(session[:merchant_id])
      if user.user_name
        return user.user_name
      elsif user.email
        return user.email
      else
        return "#{user.provider} user #{user.uid}"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: user not in database"
    end
  end

  def login_status
    if session[:merchant_id].nil?
      sign_up_button
    else
      "Logged in as #{user_name}"
    end
  end

  def login_button(**kwargs)
    if session[:merchant_id].nil?
      text = "Log In"
      path = "/auth/github"
      method = :get
    else
      text = "Log Out"
      path = sessions_path
      method = :delete
    end
    link_to text, path, method: method, **kwargs
  end

  def sign_up_button(**kwargs)
    if session[:merchant_id].nil?
      text = "Sign Up with Github"
      path = "https://github.com/join?source=header-home"
      method = :get
    end
    link_to text, path, method: method, **kwargs
  end

  def product_image(product, **kwargs)
    if product.image.nil?
      path = "no_image.png"
      dimensions = "80x60"
      text = "Robits"
    else
      path = (product.image_stored? ? product.image.thumb('80x60').url : "")
      dimensions = "80x60"
      text = "Buy Me"
    end
    image_tag path, size: dimensions, alt: text
  end



  def render_date(date)
    ("<span class='date'>" + date.strftime("%A, %b %d %Y") +  "</span>").html_safe
  end

end
