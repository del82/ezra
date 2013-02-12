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

    describe "should not allow access to DELETE #index" do
      let(:user) { FactoryGirl.create(:user) }
      it "does not delete the user" do
        user # create the user before it's needed
        expect { delete :destroy, id: user }.to_not change(User, :count)
      end
      it "redirects to signin page" do 
        delete :destroy, id: user
        response.should redirect_to(signin_path)
      end
    end
  end
  
  # context "authenticated as non-owner user" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   let(:non_owner) { FactoryGirl.create(:user) }
  #   before { sign_in non_owner }

  #   describe "should not allow access to GET #index" do
  #     before { get :index, id: non_owner.id}
  #     it "does not render the :index view" do
  #       response.should_not render_template :index
  #     end
  #     it "redirects to signin page" do
  #       response.should redirect_to(signin_path)
  #     end
  #   end 

#     describe "should not allow access to GET #show" do
#       before { get :show, id: non_owner.id }
#       it "does not render the :show view" do
#         response.should_not render_template :show
#       end
#       it "redirects to signin page" do
#         response.should redirect_to(signin_path)
#       end
#     end 

#     describe "should not allow access to GET #new" do
#       before { get :new,  id: non_owner.id }
#       it "does not render the :new view" do
#         response.should_not render_template :new
#       end
#       it "redirects to signin page" do
#         response.should redirect_to(signin_path)
#       end
#     end 

#     pending "should not allow access to POST #create"
#     pending "should not allow access to GET #edit"
#     pending "should not allow access to PUT #update"
#     pending "should not allow access to DELETE #index"
#   end

#   context "authenticated as owner user" do
#     let(:user) { FactoryGirl.create(:user) }
#     pending "should not allow access to GET #index"
#     pending "should not allow access to GET #show"
#     pending "should not allow access to GET #new"
#     pending "should not allow access to POST #create"
#     pending "should not allow access to GET #edit"
#     pending "should not allow access to PUT #update"
#     pending "should not allow access to DELETE #index"
#   end

#   context "authenticated as admin" do
#     let(:user) { FactoryGirl.create(:user) }
#     let(:admin) { FactoryGirl.create(:admin) }
#     pending "should not allow access to GET #index"
#     pending "should not allow access to GET #show"
#     pending "should not allow access to GET #new"
#     pending "should not allow access to POST #create"
#     pending "should not allow access to GET #edit"
#     pending "should not allow access to PUT #update"
#     pending "should not allow access to DELETE #index"
#  end
end
