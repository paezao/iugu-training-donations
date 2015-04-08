class UserController < ApplicationController
  
  def login
    
  end

  def signup
    
  end

  def register
    User.create(user_params) 

    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
