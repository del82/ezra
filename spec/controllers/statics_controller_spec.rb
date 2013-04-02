require 'spec_helper'

describe StaticsController do

  let(:static) { FactoryGirl.create(:static) }

  context "unauthenticated" do

    pending "GET index" do
      it "assigns all statics as @statics" do
        static = Static.create! valid_attributes
        get :index, {}, valid_session
        assigns(:statics).should eq([static])
      end
    end

    describe "GET show" do
      it "assigns the requested static as @static" do
        get :show, { id: static.to_param }
        assigns(:static).should eq(static)
      end

      describe "if the requested page doesn't exist" do
        before { get :show, { id: "this doesn't exist" } }
        it "does not render :show" do
          response.should_not render_template :show
        end

        it "redirects to 404 page" do
          response.should redirect_to('/404')
        end
      end
    end

    pending do # del82
      describe "GET new" do
        it "assigns a new static as @static" do
          get :new, {}, valid_session
          assigns(:static).should be_a_new(Static)
        end
      end

      describe "GET edit" do
        it "assigns the requested static as @static" do
          static = Static.create! valid_attributes
          get :edit, {:id => static.to_param}, valid_session
          assigns(:static).should eq(static)
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new Static" do
            expect {
              post :create, {:static => valid_attributes}, valid_session
            }.to change(Static, :count).by(1)
          end

          it "assigns a newly created static as @static" do
            post :create, {:static => valid_attributes}, valid_session
            assigns(:static).should be_a(Static)
            assigns(:static).should be_persisted
          end

          it "redirects to the created static" do
            post :create, {:static => valid_attributes}, valid_session
            response.should redirect_to(Static.last)
          end
        end

        describe "with invalid params" do
          it "assigns a newly created but unsaved static as @static" do
            # Trigger the behavior that occurs when invalid params are submitted
            Static.any_instance.stub(:save).and_return(false)
            post :create, {:static => {}}, valid_session
            assigns(:static).should be_a_new(Static)
          end

          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            Static.any_instance.stub(:save).and_return(false)
            post :create, {:static => {}}, valid_session
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        describe "with valid params" do
          it "updates the requested static" do
            static = Static.create! valid_attributes
            # Assuming there are no other statics in the database, this
            # specifies that the Static created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            Static.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
            put :update, {:id => static.to_param, :static => {'these' => 'params'}}, valid_session
          end

          it "assigns the requested static as @static" do
            static = Static.create! valid_attributes
            put :update, {:id => static.to_param, :static => valid_attributes}, valid_session
            assigns(:static).should eq(static)
          end

          it "redirects to the static" do
            static = Static.create! valid_attributes
            put :update, {:id => static.to_param, :static => valid_attributes}, valid_session
            response.should redirect_to(static)
          end
        end

        describe "with invalid params" do
          it "assigns the static as @static" do
            static = Static.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            Static.any_instance.stub(:save).and_return(false)
            put :update, {:id => static.to_param, :static => {}}, valid_session
            assigns(:static).should eq(static)
          end

          it "re-renders the 'edit' template" do
            static = Static.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            Static.any_instance.stub(:save).and_return(false)
            put :update, {:id => static.to_param, :static => {}}, valid_session
            response.should render_template("edit")
          end
        end
      end

      describe "DELETE destroy" do
        it "destroys the requested static" do
          static = Static.create! valid_attributes
          expect {
            delete :destroy, {:id => static.to_param}, valid_session
          }.to change(Static, :count).by(-1)
        end

        it "redirects to the statics list" do
          static = Static.create! valid_attributes
          delete :destroy, {:id => static.to_param}, valid_session
          response.should redirect_to(statics_url)
        end
      end

    end
  end
end
