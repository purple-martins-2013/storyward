require 'spec_helper'

describe ProfilesController do
  render_views

  let(:user){ FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "#show" do
    it "shows a list of profiles" do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end
