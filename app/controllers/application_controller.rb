class ApplicationController < ActionController::Base
  include SessionManager

  protect_from_forgery
  before_filter :check_auth

  private

  def check_auth
    @current_user = current_user
  end

  def current_user_back
    if cookies[:auth_user_id]
      @current_user ||= User.find(cookies[:auth_user_id])  
    end
    # @_current_user ||= session[:current_user_id] &&
    #   User.find_by_id(session[:current_user_id])
  end
end
