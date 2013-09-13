require "spec_helper"

describe "profile index page" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click
    click_link "Browse Authors"
  end

  it "contains an entry for our default user" do
    assert page.has_content? @user.name
  end

end

describe "profile page" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click

    @story = FactoryGirl.create(:story)
  end
    
  context "see the empty profile page" do
  
    before(:each) do
      click_link "My Profile"
    end

    it "contains the user's name" do
      expect(page.has_content? @user.name).to be_true
    end

    it "has headings for all relevant profile categories" do
      expect(page.has_content? "Stories Created").to be_true
      expect(page.has_content? "Nodes Contributed").to be_true
      expect(page.has_content? "Favorite Authors").to be_true
      expect(page.has_content? "Favorite Stories").to be_true
    end

    it "provides empty disclaimers when profile is empty" do
      expect(page.has_content? "No stories created yet.").to be_true
      expect(page.has_content? "No nodes created yet.").to be_true
      expect(page.has_content? "No authors favorited yet.").to be_true
      expect(page.has_content? "No stories favorited yet.").to be_true
    end

  end

  context "see a story created by the user" do

    before(:each) do
      @node = FactoryGirl.build(:node)
      visit new_story_path
      page.fill_in "Title", :with => @node.title
      fill_in "Content", :with => @node.content
      click_button "Create Story"
      click_link "My Profile"
    end

    it "shows the recently created story" do
      expect(page.has_content? @node.title).to be_true
      page.should have_no_content "No stories created yet."
    end

    it "shows a node created by the user" do
      @node = @story.node
      visit story_path(@story)
      click_link "Create a New Branch!"
      page.fill_in "Title", :with => "tribbles"
      fill_in "Content", :with => @node.content
      click_button "Create Story"
      click_link "My Profile"

      expect(page.has_content? "tribbles").to be_true
      page.should have_no_content "No stories created yet."
      page.should have_no_content "No nodes created yet."
    end

  end
end

