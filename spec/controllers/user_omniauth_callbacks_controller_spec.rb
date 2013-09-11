require 'spec_helper'

describe Users::OmniauthCallbacksController, "OmniAuth" do

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "sets a session variable to the OmniAuth auth hash from facebook" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    request.env["omniauth.auth"][:uid].should == '1234'
  end

   it "sets a session variable to the OmniAuth auth hash from twitter" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    request.env["omniauth.auth"][:uid].should == '1234'
  end


end
