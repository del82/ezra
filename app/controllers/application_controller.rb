class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

protected  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

end
