class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :make_statics_available

protected
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def make_statics_available
    @statics = Static.all
  end
end
