require 'spec_helper'

describe TargetsController do

  context "unauthenticated" do
    let(:user) { FactoryGirl.create(:user) }
    let(:target) { FactoryGirl.create(:target) }

    describe "should not allow access to GET #index" do
      before { get :index }
      it "does not render the :index view" do
        response.should_not render_template :index
      end
      it "redirects to signin page" do
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to GET #show" do
      before { get :show, id: target }
      it "does not render the :show view" do
        response.should_not render_template :show
      end
      it "redirects to signin page" do
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to GET #new" do
      before { get :new }
      it "does not render the :new view" do
        response.should_not render_template :new
      end
      it "redirects to signin page" do
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to POST #create" do
      it "does not create a new target" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:target)
        }.to_not change(Target, :count)
      end
      it "redirects to signin page" do
        post :create, user: FactoryGirl.attributes_for(:target)
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: target }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to PUT #update" do
      it "does not change the user" do
        put :update, id: target,
                   target: FactoryGirl.attributes_for(:target, phrase: "wrong")
        target.reload
        target.phrase.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: target, target: FactoryGirl.attributes_for(:target)
        response.should redirect_to(signin_path)
      end
    end

    # describe "should not allow access to DELETE #index" do
    #   let(:user) { FactoryGirl.create(:user) }
    #   it "does not delete the user" do
    #     user # create the user before it's needed
    #     expect { delete :destroy, id: user }.to_not change(User, :count)
    #   end
    #   it "redirects to signin page" do
    #     delete :destroy, id: user
    #     response.should redirect_to(signin_path)
    #   end
    # end
  end

# ----
  context "authenticated as user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:target) { FactoryGirl.create(:target, id: 500) }

    before { sign_in user }

    describe "should allow access to GET #index" do
      before { get :index }
      it "renders the :index view" do
        response.should render_template :index
        assigns(:targets).should eq([target])
      end
    end

    describe "should allow access to GET #show" do
      before { get :show, id: target }
      it "renders the :show view" do
        response.should render_template :show
        assigns(:target).should eq(target)
      end
      describe "returns hits and features" do
        before do
          FactoryGirl.create(:hit) # not target_id: 500
          FactoryGirl.create(:hit, target_id: 500)
          FactoryGirl.create(:hit, target_id: 500, confirmed: 1)
          FactoryGirl.create(:hit, target_id: 500, flagged: true)
          FactoryGirl.create(:feature) # not assigned to target
          feat = FactoryGirl.create(:feature)
          feat.targets << target
        end
        it "filters on target" do
          get :show, id: target
          response.should render_template :show
          assigns(:hits).length.should eq(3)
        end
        it "returns correct features" do
          get :show, id: target
          assigns(:features).length.should eq(1)
        end
        describe "respects parameters" do
          it "filters on confirmation parameter" do
            get :show, id: target, confirmed: 1
            response.should render_template :show
            assigns(:hits).length.should eq(1)
          end
          it "filters on flagged parameter" do
            get :show, id: target, flagged: "true"     # must be string
            response.should render_template :show
            assigns(:hits).length.should eq(1)
          end
        end
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
      it "does not create a new target" do
        expect {
          post :create, user: user,
                        target: FactoryGirl.attributes_for(:target)
        }.to_not change(Target, :count)
      end
      it "redirects to signin page" do
          post :create, user: user,
                        target: FactoryGirl.attributes_for(:target)
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: target }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to PUT #update" do
      it "does not change the target" do
        put :update, id: target,
                    target: FactoryGirl.attributes_for(:target, phrase: "wrong")
        target.reload
        target.phrase.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: target,
                    target: FactoryGirl.attributes_for(:target, phrase: "wrong")
        response.should redirect_to(user_path(user))
      end
    end
  end

# ----
  context "authenticated as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:target) { FactoryGirl.create(:target) }

    before { sign_in admin }

    describe "should allow access to GET #index" do
      before { get :index }
      it "renders the :index view" do
        response.should render_template :index
        assigns(:targets).should eq([target])
      end
    end

    describe "should allow access to GET #show" do
      before { get :show, id: target }
      it "renders the :show view" do
        response.should render_template :show
        assigns(:target).should eq(target)
      end
    end

    describe "should allow access to GET #new" do
      before { get :new }
      it "renders the :new view" do
        response.should render_template :new
        assigns(:target).should_not be_nil
      end
    end

    describe "should allow access to POST #create" do
      context "with valid information" do
        let(:new_target) { FactoryGirl.attributes_for(:target) }
        it "creates a new target" do
          expect{ post :create, target: new_target
                 }.to change(Target, :count).by(1)
        end
        it "redirects to the new target's page" do
          post :create, target: new_target
          response.should render_template :show
        end
      end
      context "create with invalid information" do
        let(:new_target) { FactoryGirl.attributes_for(:target, phrase: "") }
        it "does not create a new target" do
          expect{ post :create, target: new_target
                 }.to_not change(Target, :count)
        end
        it "remains on new target page" do
          response.should render_template :new
        end
      end
    end

    describe "should allow access to GET #edit" do
      before { get :edit, id: target }
      it "renders the :edit view" do
        response.should render_template :edit
      end
    end

    describe "should allow access to PUT #update" do
      let(:new_target) { FactoryGirl.attributes_for(:target,
                                                    phrase: "New Phrase") }
      context "with valid information" do
        before { put :update, id: target, target: new_target }
        it "should update the target"  do
          target.reload
          target.phrase.should eq("New Phrase")
        end
        it "should render the :show template on success" do
          response.should render_template :show
        end
      end
    end

    # pending "should allow access to DELETE #destroy"
  end

end
