require "spec_helper"

describe "allow log in via views" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
  end

  it "takes you to your profile page on successful login" do
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click
    current_path.should eq "/profiles/#{@user.id}"
  end

  it "shows the nav bar after logging in, reflecting a successful login" do
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click
    assert page.has_content? "Browse Stories"
    assert page.has_content? "My Profile"
    assert page.has_content? "Create a Story"
    assert page.has_content? "Logout"
  end

  it "redirects you to the welcome page on unsuccessful login" do
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => "incorrect"
    page.find('.button').click
    current_path.should eq "/"
  end

end
