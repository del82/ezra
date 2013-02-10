class FeaturesController < ApplicationController
  before_filter :signed_in_user
  def index   # GET /features          -> features_path
  end

  def show    # GET /features/:id      -> feature_path(feature) 
    @feature = Feature.find(params[:id])
  end

  def new     # GET /features/new      -> new_feature_path
  end

  def create  # POST /features         -> features_path
  end

  def edit    # GET /features/:id/edit -> edit_feature_path(feature)
    @feature = Feature.find(params[:id])
  end

  def update  # PUT /features/1        -> feature_path(feature)
  end

  def destroy # DELETE /features/1     -> feature_path(feature)
  end

private
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

end
