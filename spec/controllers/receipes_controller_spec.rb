require 'spec_helper'

describe ReceipesController do
  describe "#index" do
    let!(:receipes) { create_list :receipe, 4 }

    it "Should list all receipes" do
      get :index

      expect(assigns(:receipes)).to eq receipes
    end

    it "Should support json requests" do
      get :index, format: :json

      response.body.should == receipes.to_json
    end
  end

  describe "#create" do
    let!(:receipe) { build :receipe }

    it "should create a receipe" do
      post :create, {receipe: receipe.as_json}

      Receipe.first.name.should == receipe.name
      response.should redirect_to assigns(:receipe)
    end

    it "should return the json representation of the object" do
      post :create, receipe: receipe.as_json, format: :json

      JSON.parse(response.body)[:receipe] == assigns(:receipe).as_json
      JSON.parse(response.body)[:success] == true
    end
  end

  describe "#update" do
    let!(:receipe) { create :receipe }

    it "should update the receipe" do
      put :update, receipe: { name: "Green" }, id: receipe.id

      assigns(:receipe).name.should == "Green"
    end
  end
end