require "spec_helper"

describe CinelistsController do
  describe "routing" do

    it "routes to #index" do
      get("/cinelists").should route_to("cinelists#index")
    end

    it "routes to #new" do
      get("/cinelists/new").should route_to("cinelists#new")
    end

    it "routes to #show" do
      get("/cinelists/1").should route_to("cinelists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cinelists/1/edit").should route_to("cinelists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cinelists").should route_to("cinelists#create")
    end

    it "routes to #update" do
      put("/cinelists/1").should route_to("cinelists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cinelists/1").should route_to("cinelists#destroy", :id => "1")
    end

  end
end
