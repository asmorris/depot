class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user.try(:authenticate, params[:password])
  		# could use if user&authenticate(params[:password]) instead
  		session[:user_id] = user.id
  		redirect_to admin_url
  	else
  		redirect_to login_url, alert: 'Invalid username and or password.'
  	end
  end

  def destroy
  	session[:user_id] =  nil
  	redirect_to store_index_url, notice: 'Logged Out'
  end
end
