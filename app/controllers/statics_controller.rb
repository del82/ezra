class StaticsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update]

  def index
    @statics = Static.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statics }
    end
  end

  # GET /statics/1
  # GET /statics/1.json
  def show
    @static = Static.find(params[:id])
    render 'public/404', :status => 404 if @static.nil?
  end

  # GET /statics/new
  # GET /statics/new.json
  def new
    @static = Static.new
  end

  # GET /statics/1/edit
  def edit
    @static = Static.find(params[:id])
  end

  # POST /statics
  # POST /statics.json
  def create
    @static = Static.new(params[:static])

    if @static.save
      flash[:success] = "Static page \"#{@static.title}\" created successfully."
      render 'show'
    else
      render 'new'
    end
  end

  # PUT /statics/1
  # PUT /statics/1.json
  def update
    @static = Static.find(params[:id])

    respond_to do |format|
      if @static.update_attributes(params[:static])
        format.html { redirect_to @static, notice: 'Static was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @static.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statics/1
  # DELETE /statics/1.json
  def destroy
    @static = Static.find(params[:id])
    @static.destroy

    respond_to do |format|
      format.html { redirect_to statics_url }
      format.json { head :no_content }
    end
  end
end
