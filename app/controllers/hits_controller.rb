require 'open-uri'
require 'securerandom'
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
    @features = Target.find(@target.id).features
  end

  def download_file
    @hit = Hit.find(params[:id])
    # url = "http://"+@hit.audio_file[6,@hit.audio_file.length]
    # name = params[:phrase].sub(/ /,'_') #+SecureRandom.uuid #is it better to use a timestamp?
    # loc = 'app/assets/audios/'+name+'.mp3'
    # open(url, 'rb') do |mp3|
    #   File.open(loc, 'wb') do |file|
    #     file.write(mp3.read)
    #   end
    # end
    startTime = '0:09'
    endTime = '0:13'
    command = 'cutmp3 -i app/assets/audios/Tromboon-sample.mp3 -a '+startTime+' -b '+endTime+' -O app/assets/audios/test.mp3'
    @cmd = `#{command}`
    # @cmd = system 'cutmp3 -i app/assets/audios/voluptas_in.mp3 -a 0:03 -b 0:05 -O app/assets/audios/test.mp3'
    flash[:success] = @cmd
    render 'show'
  end

  def update  # PUT /hits/:id  -> hit_path(hit)
    @hit = Hit.find(params[:id])
    @target = @hit.target
    if @hit.update_attributes(params[:hit], user: @user)
      flash[:success] = "Successfully updated hit #"+params[:id]
      @hit.create_activity(:update, owner: current_user, recipient: @target,
                           params: { phrase: @target.phrase })
      
      @next = Target.find(@target.id).hits.where(confirmed: '0').first
      if @next.nil?
        redirect_to current_user, :notice => "No more unconfirmed hits"
      else
        @userStats = current_user.stats
        @userStats.recent = @target.id
        @userStats.save()
        redirect_to :action => 'edit', :id => @next.id
      end
    else
      render 'edit'
    end
  end
end
