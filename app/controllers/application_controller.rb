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
end
