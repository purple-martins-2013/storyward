require "spec_helper"

describe "browsing and reading stories" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click

    @node = FactoryGirl.build(:node)
    visit new_story_path
    page.fill_in "Title", :with => @node.title
    fill_in "Content", :with => @node.content
    click_button("Create Story")

    @story = FactoryGirl.create(:story)
  end
    

  context "when viewing a story's main page" do

    before(:each) do
      @node = Node.where(title: @node.title).first
      visit node_path(@node)
    end

    it "contains story information for the first node" do
      expect(page.has_content? @node.title).to be_true
      expect(page.has_content? "Started by #{@user.name}").to be_true
      expect(page.has_content? @node.content).to be_true
    end

  end

  context "when reading a story chain" do

    before(:each) do
      @node = @story.node
      visit story_path(@story)
    end

    it "contains story information for the existing node" do
      expect(page.has_content? @node.title).to be_true
      expect(page.has_content? @node.content).to be_true
    end

    it "contains a link to creating a new branch" do
      expect(page.has_link? "Create a New Branch!", "/stories/new/#{@node.id}").to be_true
    end

    it "allows the user to navigate to create a new branch of the existing node" do
      click_link "Create a New Branch!"
      expect(page.has_content? @node.title).to be_true
      expect(page.has_content? "Continue the story!").to be_true
    end

  end

end

