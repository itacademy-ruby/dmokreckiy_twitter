module SessionManager

  def sign_in
    'sing_in'
  end

  def current_user
    session_id = cookies[:session_id]
    user = User.find_by_session(session_id)

    return user if user
    nil
  end

end
