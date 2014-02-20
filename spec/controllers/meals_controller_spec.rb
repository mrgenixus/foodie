require 'spec_helper'

describe MealsController do
  before do
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe "GET index" do
    it "gathers a list of the users meals for this week" do
      FactoryGirl.create(:meal, day: 1.day.from_now)
      FactoryGirl.create(:meal, day: 6.days.from_now)

      get :index

      expect(assigns(:meals)).to match_array(Meal.all)
    end
  end
end
