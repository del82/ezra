class TargetsController < ApplicationController
  before_filter :signed_in_user
  def index   # GET /targets          -> targets_path
    @targets = Target.paginate(page: params[:page])
  end

  def show    # GET /targets/:id      -> target_path(target) 
    @target = Target.find(params[:id])
  end

  def new     # GET /targets/new      -> new_target_path
    @target = Target.new
  end

  def create  # POST /targets         -> targets_path
  end

  def edit    # GET /targets/:id/edit -> edit_target_path(target)
    @target = Target.find(params[:id])
  end

  def update  # PUT /targets/1        -> target_path(target)
  end

  def destroy # DELETE /targets/1     -> target_path(target)
  end
end
