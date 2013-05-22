require 'open-uri'
require 'open3'
class HitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user, only: [:new, :create]

  def index
    hits_params = params.slice(:target_id, :confirmed, :flagged)
    if hits_params.has_key?(:flagged)
      hits_params[:flagged] = (hits_params[:flagged] == "true")
    end
    # @hits   = Hit.where(hits_params).paginate(page: params[:page])
    @hits = Hit.where(hits_params).paginate(page: params[:page] )
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
    @features = @target.features
    # @features = Target.find(@target.id).features
  end

  def save_clip
    @hit = Hit.find(params[:id])
    phrase = @hit.target.phrase.gsub!(/ /,'_')

    # Check to see if directory stucture is correct
    # TODO: Move to an install script
    if !Dir.exists?('public/clips')
      Dir.mkdir('public/clips')
    end
    if !Dir.exists?('public/clips/'+phrase)
      Dir.mkdir('public/clips/'+phrase)
    end


    rawLoc = 'app/assets/audios/'+@hit.audio_file[6,@hit.audio_file.length]
    fileExists = File.exists?(rawLoc)

    # This is the code to download from the web.  Should be moved to an import controller
    # if !File.exist?(rawLoc)
    #   url = "http://"+@hit.audio_file[6,@hit.audio_file.length]
    #   open(url, 'rb') do |mp3|
    #     File.open(rawLoc, 'wb') do |file|
    #       file.write(mp3.read)
    #     end
    #   end
    # end

    clipName = phrase+"_id-"+params[:id]+"_"+Time.now.strftime("%Y%m%dT%H%M")
    cutLoc = 'public/clips/'+phrase+'/'+clipName+'.mp3'

    if fileExists
      # Include the : to force cutmp3 to use seconds, otherwise, if there are no
      # trailing decimals, it will assume minutes
      startTime = ':'+params[:startTime]
      endTime = ':'+params[:endTime]
      command = 'cutmp3 -i '+rawLoc+' -a '+startTime+' -b '+endTime+' -O '+cutLoc
      @cmd = system command
    end

    respond_to do |format|
      if File.exist?(cutLoc)
        format.json { render :json => {:link => '/clips/'+phrase+'/'+clipName+'.mp3'}}
      else
        if fileExists
          # cutmp3 doesn't output to stderr (only stdout), so in order to get the correct error
          # we need to re-run the process. All other shell calling methods return stdout (which is useless when
          # checking if successful in this case), except 'system'
          error = `#{command}`
        else
          error = "Audio file doesn't exist in correct spot or is corrupted, please contact Admin"
        end
        format.json { render :json => {:errors => error }, :status => 422}

      end

    end
  end

  def listen
    redirect_to ActionController::Base.helpers.asset_path(params[:clip]+".mp3")
  end

  def update  # PUT /hits/:id  -> hit_path(hit)
    @hit = Hit.find(params[:id])
    @target = @hit.target
    @features = @target.features
    if !params.has_key?(:cancel) && @hit.update_attributes(params[:hit], user: @user)
      flash[:success] = "Successfully updated hit #"+params[:id]
      @hit.create_activity(:update, owner: current_user, recipient: @target,
                           params: { phrase: @target.phrase })

      @next = @hit
      if params[:commit] === 'Next Unconfirmed'
        @next = Target.find(@target.id).hits.where('confirmed = ? AND flagged = ?', 0, false).first
      elsif params[:commit] === 'Next'
        # @next = Target.find(@target.id).hits.where("id > ?", @hit.id).order("id ASC").first
        @next = Hit.where("id > ?", @hit.id).order("id ASC").first
      elsif params[:commit] === 'Previous'
        # @next = Target.find(@target.id).hits.where("id < ?", @hit.id).order("id DESC").first
        @next = Hit.where("id < ?", @hit.id).order("id DESC").first
      end

      if @next.nil?
        redirect_to current_user, :notice => "No more hits"
      else
        redirect_to :action => 'edit', :id => @next.id
      end
    else
      render 'edit'
    end
  end
end
