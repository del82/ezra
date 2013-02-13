require 'spec_helper'

describe UsersController do

  context "unauthenticated" do
    let(:user) { FactoryGirl.create(:user) }

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
      before { get :show, id: user }
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
      it "does not create a new user" do
        expect { 
          post :create, user: FactoryGirl.attributes_for(:user) 
        }.to_not change(User, :count)
      end
      it "redirects to signin page" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to(signin_path)
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: user }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(signin_path)
      end
    end 

    describe "should not allow access to PUT #update" do
      let(:user) { FactoryGirl.create(:user) }
      it "does not change the user" do
        put :update, id: user, user: FactoryGirl.attributes_for(:user, name: "wrong")
        user.reload
        user.name.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: user, user: FactoryGirl.attributes_for(:user)
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

#-----
  context "authenticated as non-owner user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_owner) { FactoryGirl.create(:user) }
    before { sign_in non_owner }

    describe "should not allow access to GET #show" do
      before { get :show, id: user.id }
      it "does not render the :show view" do
        response.should_not render_template :show
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(non_owner))
      end
    end 

    describe "should not allow access to GET #edit" do
      before { get :edit, id: user }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(non_owner))
      end
    end 

    describe "should not allow access to PUT #update" do
      let(:user) { FactoryGirl.create(:user) }
      it "does not change the user" do
        put :update, id: user, user: FactoryGirl.attributes_for(:user, name: "wrong")
        user.reload
        user.name.should_not eq("wrong")
      end
      it "redirects to signin page" do
        put :update, id: user, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to(user_path(non_owner))
      end
    end
  end

#----
  context "authenticated as owner user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    
    describe "should not allow access to GET #index" do
      before { get :index }
      it "does not render the :index view" do
        response.should_not render_template :index
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(user))
      end
    end 
  

    describe "should allow access to GET #show" do
      before { get :show, id: user }
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
      it "does not create a new user" do
        expect { 
          post :create, user: FactoryGirl.attributes_for(:user) 
        }.to_not change(User, :count)
      end
      it "redirects to signin page" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to(user_path(user))
      end
    end

    describe "should allow access to GET #edit" do
      before { get :edit, id: user }
      it "renders the :edit view" do
        response.should render_template :edit
      end
    end
        
    describe "should allow access to PUT #update" do
      context "with valid information" do
        before { 
          put :update, id: user, 
                       user: FactoryGirl.attributes_for(:user, name: "New Name")
        }
        it "should update the user" do
          user.reload
          user.name.should eq("New Name")
        end
        it "should render the :show template on success" do
          response.should render_template :show
        end
      end

      describe "with invalid information" do
        before {
          put :update, id: user,
                       user: FactoryGirl.attributes_for(:user, name: "")
        }
        it "should not update the user" do
          user.reload
          user.name.should_not eq("")
        end
        it "should re-render the :edit template" do
          response.should render_template :edit
        end
      end
    end  

    #pending "should not allow access to DELETE #index"
  end

#----

  context "authenticated as admin" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }
    before { sign_in admin }

    describe "should allow access to GET #index" do
      before { get :index }
      it "renders the :index view" do
        response.should render_template :index
      end
    end 

    describe "should allow access to GET #show" do
      before { get :show, id: user }
      it "renders the :show view" do
        response.should render_template :show
      end
    end

    describe "should allow access to GET #new" do
      before { get :new }
      it "renders the :new view" do
        response.should render_template :new
      end
    end
    
    describe "should allow access to POST #create" do
      context "with valid information" do
        let(:new_user) { FactoryGirl.attributes_for(:user) }
        it "creates a new user" do
          expect{ post :create, user: new_user }.to change(User, :count).by(1)
        end
        it "redirects to the new user's page" do
          post :create, user: new_user
          response.should render_template :show
        end
      end
      context "create with invalid information" do
        let(:new_user) { FactoryGirl.attributes_for(:user, name: "") }
        it "does not create a new user" do
          expect{ post :create, user: new_user }.to_not change(User, :count)
        end
        it "remains on new user page" do
          response.should render_template :new
        end
      end
    end

    describe "should allow access to GET #edit" do
      before { get :edit, id: user }
      it "renders the :edit view" do
        response.should render_template :edit
      end
    end

    
    describe "should allow access to PUT #update" do
      let(:new_user) { FactoryGirl.attributes_for(:user, name: "New Name") }
      context "with valid information" do
        before { put :update, id: user, user: new_user }
        it "should update the user"  do
          user.reload
          user.name.should eq("New Name")
        end
        it "should render the :show template on success" do
          response.should render_template :show
        end
      end

      context "with invalid information" do
        before {
          put :update, id: user,
                       user: FactoryGirl.attributes_for(:user, name: "")
        }
        it "should not update the user" do
          user.reload
          user.name.should_not eq("")
        end
        it "should re-render the :edit template" do
          response.should render_template :edit
        end
      end

    end
  end
end
