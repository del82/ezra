class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

protected  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_path) unless current_user?(@user)
 end

  def correct_user_or_admin
    redirect_to(user_path(@user)) unless correct_user || admin_user
  end

  def admin_user
    redirect_to(user_path(@user)) unless admin_user
  end

end
