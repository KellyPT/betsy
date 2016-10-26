class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  def current_merchant
    begin
      @current_merchant ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
    rescue ActiveRecord::RecordNotFound
    end
  end

  def require_login
    if current_merchant.nil?
      flash[:error] = "You have been logged out. Please continue to browse our website as a Guest User."
      redirect_to root_path
    end
  end
end
