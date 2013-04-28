class UsersController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :correct_user, only: []
  before_filter :correct_user_or_admin, only: [:show, :edit, :update]
  before_filter :admin_user, only: [:index, :new, :create]


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
    @stats = Stats.new(:recent => @user.id)
    @user.stats = @stats
    if @user.save
      flash[:success] = "User #{@user.username} created successfully."
      render 'show'
    else
      render 'new'
    end
  end

  def edit    # GET /users/:id/edit -> edit_user_path(user)
    @user = User.find(params[:id])
  end

  def update  # PUT /users/1        -> user_path(user)
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Update successful."
      sign_in @user
      render 'show'
    else
      render 'edit'
    end
  end

  def recent # GET /users/:id/recent
    @user = User.find(params[:id])
    if @user.stats.recent.blank?
      render 'show'
    else
      @target = Target.find(@user.stats.recent.to_s)
      @next = Target.find(@target.id).hits.where(confirmed: '0').first
      redirect_to :controller => 'hits', :action => 'edit', :id => @next.id
    end
  end


  def manage #GET/users/manage/:id
    @user = User.find(params[:id])
    @stats = @user.stats
    @targets = Target.all

  end

  def manage_save
    @user = User.find(params[:id])
    @user.stats.availableTargets = params[:availableTargets]
    if @user.stats.save
      render 'show'
    else
      render 'manage'
    end
  end
end
