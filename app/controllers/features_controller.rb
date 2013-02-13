class FeaturesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update]

  def index   # GET /features          -> features_path
    @features = Feature.paginate(page: params[:page])
  end

  def show    # GET /features/:id      -> feature_path(feature) 
    @feature = Feature.find(params[:id])
  end

  def new     # GET /features/new      -> new_feature_path
  end

  def create  # POST /features         -> features_path
    @feature = current_user.features.build(params[:feature])
    if @feature.save
      flash[:success] = "Feature \"#{@feature.name}\" created successfully."
      render 'show'
    else
      render 'new'
    end
  end


  def edit    # GET /features/:id/edit -> edit_feature_path(feature)
    @feature = Feature.find(params[:id])
  end

  def update  # PUT /features/1        -> feature_path(feature)
    @feature = Feature.find(params[:id])
    if @feature.update_attributes(params[:feature], user: @user)
      flash[:success] = "Update successful."
      render 'show'
    else
      render 'edit'
    end
  end


  # def destroy # DELETE /features/1     -> feature_path(feature)
  # end

end
