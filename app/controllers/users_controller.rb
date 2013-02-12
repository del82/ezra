class UsersController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user_or_admin

  def index   # GET /users          -> users_path
    @users = User.paginate(page: params[:page])
  end

  def show    # GET /users/:id      -> user_path(user) 
    @user = User.find(params[:id])
  end

  def new     # GET /users/new      -> new_user_path
    @user = User.new
  end

  def create  # POST /users         -> users_path
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User #{@user.username} created successfully."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit    # GET /users/:id/edit -> edit_user_path(user)
    @user = User.find(params[:id])
  end

  def update  # PUT /users/1        -> user_path(user)
    @user = User.find(params[:id])
  end

  def destroy # DELETE /users/1     -> user_path(user)
  end

end
