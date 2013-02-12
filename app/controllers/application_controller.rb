class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

protected  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user_or_admin
    redirect_to(user_path(@user)) unless correct_user || admin_user
  end

  def admin_user
    redirect_to(user_path(@user)) unless admin_user
  end

end
