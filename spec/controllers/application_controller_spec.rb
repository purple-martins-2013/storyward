require 'spec_helper'

describe ApplicationController do
  let(:user) { FactoryGirl.create(:user) }

  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  describe "After sigin-in" do
    it "redirects to the /jobs page" do
      controller.after_sign_in_path_for(user).should == profile_path(user)
    end
  end
end
