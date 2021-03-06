class TargetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user, only: [:new, :create, :edit, :update]

  # deferred in v1.0
#  before_filter :check_available_targets, only: [:show,:edit]

  def index   # GET /targets          -> targets_path
    @targets = Target.paginate(page: params[:page])
  end

  def show    # GET /targets/:id      -> target_path(target)
    @target = Target.find(params[:id])
    @user = current_user
    hits_params = params.slice(:confirmed, :flagged)
    if hits_params.has_key?(:flagged)
      hits_params[:flagged] = (hits_params[:flagged] == "true")
    end
    if hits_params.has_key?(:confirmed)
      @status = hits_params[:confirmed]
    end
    @hits = @target.hits.where(hits_params).paginate(page: params[:page])
    @features = @target.features
    phrase = @target.phrase.gsub(/ /,'_')
    @savedFiles = Dir.glob('public/clips/'+phrase+'/*.mp3')
  end

  def new     # GET /targets/new      -> new_target_path
    @target = Target.new
  end

  def create  # POST /targets         -> targets_path
    @target = current_user.targets.build(params[:target])
    if @target.save
      flash[:success] = "Target \"#{@target.phrase}\" created successfully."
      render 'show'
    else
      render 'new'
    end
  end

  def edit    # GET /targets/:id/edit -> edit_target_path(target)
    @target = Target.find(params[:id])
  end

  def update  # PUT /targets/1        -> target_path(target)
    @target = Target.find(params[:id])
    if @target.update_attributes(params[:target], user: @user)
      flash[:success] = "Update successful."
      redirect_to target_path(@target)
    else
      render 'edit'
    end
  end

  #def destroy # DELETE /targets/1     -> target_path(target)
  #end
  private

  def check_available_targets
    # current_user = User.new
    # stats = Stats.new
    # current_user.stats = stats
    if !current_user.stats.availableTargets.include?(params[:id]) && !current_user.stats.availableTargets.empty?
      flash[:notice] = "You are not authorized to edit this target"
      @targets = Target.paginate(page: params[:page])
      #redirect_to :action => 'index'
      render 'index'
    end
  end
end
