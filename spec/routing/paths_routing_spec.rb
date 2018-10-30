require "rails_helper"

RSpec.describe PathsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/paths").to route_to("paths#index")
    end

    it "routes to #new" do
      expect(:get => "/paths/new").to route_to("paths#new")
    end

    it "routes to #show" do
      expect(:get => "/paths/1").to route_to("paths#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/paths/1/edit").to route_to("paths#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/paths").to route_to("paths#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/paths/1").to route_to("paths#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/paths/1").to route_to("paths#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/paths/1").to route_to("paths#destroy", :id => "1")
    end
  end
end
