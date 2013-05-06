require 'spec_helper'

describe FeaturesController do

  context "unauthenticated" do
    let(:user) { FactoryGirl.create(:user) }
    let(:feature) { FactoryGirl.create(:feature) }

    describe "should not allow access to GET #index" do
      before { get :index }
      it "does not render the :index view" do
        response.should_not render_template :index
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #show" do
      before { get :show, id: feature }
      it "does not render the :show view" do
        response.should_not render_template :show
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #new" do
      before { get :new }
      it "does not render the :new view" do
        response.should_not render_template :new
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to POST #create" do
      it "does not create a new feature" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:feature)
        }.to_not change(Feature, :count)
      end
      it "redirects to signin page" do
        post :create, user: FactoryGirl.attributes_for(:feature)
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: feature }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to PUT #update" do
      it "does not change the user" do
        put :update, id: feature,
                   feature: FactoryGirl.attributes_for(:feature, name: "wrong")
        feature.reload
        feature.name.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: feature, feature: FactoryGirl.attributes_for(:feature)
        response.should redirect_to(new_user_session_path)
      end
    end
  end

# ----
  context "authenticated as user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:feature) { FactoryGirl.create(:feature) }

    before { sign_in user }

    describe "should allow access to GET #index" do
      before { get :index }
      it "renders the :index view" do
        response.should render_template :index
      end
    end

    describe "should allow access to GET #show" do
      before { get :show, id: feature }
      it "renders the :show view" do
        response.should render_template :show
      end
    end

    describe "should not allow access to GET #new" do
      before { get :new }
      it "does not render the :new view" do
        response.should_not render_template :new
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to POST #create" do
      it "does not create a new feature" do
        expect {
          post :create, #user: user,
                        feature: FactoryGirl.attributes_for(:feature)
        }.to_not change(Feature, :count)
      end
      it "redirects to signin page" do
          post :create, user: user,
                        feature: FactoryGirl.attributes_for(:feature)
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: feature }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to PUT #update" do
      it "does not change the feature" do
        put :update, id: feature,
                    feature: FactoryGirl.attributes_for(:feature, name: "wrong")
        feature.reload
        feature.name.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: feature,
                    feature: FactoryGirl.attributes_for(:feature, name: "wrong")
        response.should redirect_to(user_path(user))
      end
    end
  end

# ----
  context "authenticated as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:feature) { FactoryGirl.create(:feature) }

    before { sign_in admin }

    describe "should allow access to GET #index" do
      before { get :index }
      it "renders the :index view" do
        response.should render_template :index
      end
      it "should render successfully" do
        response.should be_success
      end
    end

    describe "should allow access to GET #show" do
      before { get :show, id: feature }
      it "renders the :show view" do
        response.should render_template :show
      end
      it "should render successfully" do
        response.should be_success
      end
    end

    describe "should allow access to GET #new" do
      before { get :new }
      it "renders the :new view" do
        response.should render_template :new
      end
      it "should render successfully" do
        response.should be_success
      end
    end


    describe "should allow access to POST #create" do
      context "with valid information" do
        let(:new_feature) { FactoryGirl.attributes_for(:feature) }
        it "creates a new feature" do
          expect{ post :create, feature: new_feature
                 }.to change(Feature, :count).by(1)
        end
        it "redirects to the new feature's page" do
          post :create, feature: new_feature
          response.should render_template :show
        end
      end
      context "create with invalid information" do
        let(:new_feature) { FactoryGirl.attributes_for(:feature, name: "") }
        it "does not create a new feature" do
          expect{ post :create, feature: new_feature
                 }.to_not change(Feature, :count)
        end
        it "remains on new feature page" do
          pending "known failure: fails to render new template"
          response.should render_template :new
        end
      end
    end

    describe "should allow access to GET #edit" do
      before { get :edit, id: feature }
      it "renders the :edit view" do
        response.should render_template :edit
      end
      it "should render successfully" do
        response.should be_success
      end
    end

    describe "should allow access to PUT #update" do
      let(:new_feature) { FactoryGirl.attributes_for(:feature,
                                                    name: "New Name") }
      context "with valid information" do
        before { put :update, id: feature, feature: new_feature }
        it "should update the feature"  do
          feature.reload
          feature.name.should eq("New Name")
        end
        it "should render the :show template on success" do
          response.should redirect_to :features
        end
      end
    end

    # pending "should allow access to DELETE #destroy"
  end

end
