class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.find_by_email(email)    
    if user && user.password_valid?(password)

      # save user to session
      session_id = rand(99999999999).to_s
      user.update_attribute(:session, session_id)
      cookies[:session_id] = session_id 
      flash[:notice] = "Congratulations!"
      redirect_to root_path
    else
      flash[:error] = "Email or password invalid."
      render :new
    end    
  end

  def destroy
    if session
      current_user.update_attribute(:session, nil)
      cookies[:session_id] = nil
    end
    redirect_to signin_path
  end
end
