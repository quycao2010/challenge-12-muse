class SessionsController < ApplicationController
  before_action :check_login, only: [:new, :create]

  def new
      
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to root_path
    else
      redirect_to login_path
    end  
  end

  def destroy
    logout
    redirect_to root_path
  end
  
  private 

  def check_login
    if current_user.present?
      redirect_to root_path,notice: "You are already login"
    end 
  end
  
  
end
