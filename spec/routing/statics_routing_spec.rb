require "spec_helper"

describe StaticsController do
  describe "routing" do

    it "routes to #index" do
      get("/statics").should route_to("statics#index")
    end

    it "routes to #new" do
      get("/statics/new").should route_to("statics#new")
    end

    it "routes to #show" do
      get("/statics/1").should route_to("statics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/statics/1/edit").should route_to("statics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/statics").should route_to("statics#create")
    end

    it "routes to #update" do
      put("/statics/1").should route_to("statics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/statics/1").should route_to("statics#destroy", :id => "1")
    end

  end
end
