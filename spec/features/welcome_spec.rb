require "spec_helper"

describe "welcome page" do

  context "when not logged in" do

    before(:each) do
      visit root_path
    end

    it "does not have a link to browse stories" do
      page.should_not have_content "Browse Stories"
    end

    it "does not have a link to my profile" do
      page.should_not have_content "My Profile"
    end

    it "has a link to create an account" do
      page.should have_content "Sign up"
    end

    it "has a link to log in" do
      page.should have_content "Sign in"
    end

  end

  context "when logged in" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
      visit root_path
    end

    describe "navbar" do

      it "has a link to browse stories" do
        page.should have_content "Browse Stories"
        click_link("Browse Stories")
        current_url.should eq "http://www.example.com" + stories_path
      end

      it "has a link to my profile" do
        page.should have_content "My Profile"
        click_link("My Profile")
        current_url.should eq "http://www.example.com/users/sign_in"
      end

    end

    describe "content" do

      it "does not have a link to create an account" do
        page.should_not have_content "Create an Account"
      end

      it "does not have a link to log in" do
        page.should_not have_content "Log In"
      end

    end

  end

end