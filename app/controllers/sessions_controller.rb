class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]

  def index; end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
    if @merchant.nil?
      @merchant = Merchant.build_from_github(auth_hash)
      render :creation_failure unless @merchant.save
    end

    # Save the user ID in the session
    session[:merchant_id] = @merchant.id
    redirect_to sessions_path
  end


  def login_failure
  end

  def login; end

  def destroy
    session.delete(:merchant_id)
    redirect_to login_failure_path #After log in, redirect to homepage
  end
end
