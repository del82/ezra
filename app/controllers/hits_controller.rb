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
    @target = @hit.target
  end

  def update  # PUT /hits/:id  -> hit_path(hit)
    @hit = Hit.find(params[:id])
    @target = @hit.target
    @next = Target.find(@target.id).hits.where(confirmed: '0').first
    if @hit.update_attributes(params[:hit], user: @user)
      flash[:success] = "Successfully updated hit #"+params[:id]
      @hit.create_activity :update, owner: current_user, params: {target_id: @target.id, phrase: @target.phrase}
      if @next.nil?
        redirect_to current_user, :notice => "No more unconfirmed hits"
      else
        redirect_to :action => 'edit', :id => @next.id
      end
    else
      render 'edit'
    end
  end
end
