class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :make_statics_available, :make_version_available

protected
  def admin_user
    redirect_to(user_path(current_user)) unless current_user.admin?
  end

  def correct_user_or_admin
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless current_user?(@user) || current_user.admin?
  end

  def current_user?(user)
    user == current_user
  end

  def make_statics_available
    @statics = Static.all
  end

  def make_version_available
    @version = Ezra::Application.config.version
  end
end
