class UsersController < ApplicationController
  def index   # GET /users          -> users_path
  end

  def show    # GET /users/:id      -> user_path(user) 
    @user = User.find(params[:id])
  end

  def new     # GET /users/new      -> new_user_path
  end

  def create  # POST /users         -> users_path
  end

  def edit    # GET /users/:id/edit -> edit_user_path(user)
    @user = User.find(params[:id])
  end

  def update  # PUT /users/1        -> user_path(user)
  end

  def destroy # DELETE /users/1     -> user_path(user)
  end

end
