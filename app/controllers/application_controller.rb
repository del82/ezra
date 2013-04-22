class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :make_statics_available, :make_version_available

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

  def make_version_available
    @version = Ezra::Application.config.version
  end
end
