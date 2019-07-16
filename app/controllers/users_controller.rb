class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  

  def create
    user = User.create(user_params)
    if user.save
      login user
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])   
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  
  private 

  def user_params
    params[:user].permit(:name, :email, :password, :password_confirmation)
  end

end
