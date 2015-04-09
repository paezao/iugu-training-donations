class UserController < ApplicationController
  
  def login_form
  end

  def new_session
    if login(params[:email], params[:password])
      redirect_to :root
    else
      flash[:danger] = "Email/Senha incorretos" 
      redirect_to login_url
    end
  end

  def do_logout
    logout
    redirect_to :root
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
