class HitsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create]

  def index
    @hits = Hit.paginate(page: params[:page] )
  end

  def show
    @hit = Hit.find(params[:id])
  end

  def new
    render 'index'
  end

  def create  # POST /hits -> hits_path
    render 'index'
  end

  def edit
    @hit = Hit.find(params[:id])
  end

  def update  # PUT /hits/:id  -> hit_path(hit)
    @hit = Hit.find(params[:id])
    if @hit.update_attributes(params[:hit], user: @user)
      flash[:success] = "Update successful."
      render 'show'
    else
      render 'edit'
    end
  end  
end
