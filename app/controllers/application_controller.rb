class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

protected  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user_or_admin
    @user = User.find(params[:id])
    redirect_to(user_path(@user)) unless current_user?(@user) || admin_user
  end

  def admin_user
    redirect_to(user_path(@user)) unless current_user.admin?
  end

end
