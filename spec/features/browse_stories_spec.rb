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
    @story = FactoryGirl.create(:story)
    Story.stub(:find_by_id).and_return(@story)
    click_button("Create Story")
  end
    
  context "browse all stories page" do
  
    before(:each) do
      visit stories_path
    end

    it "contains the created story/node" do
      assert page.has_content? @node.title
      assert page.has_content? "Started by #{@user.name}"
    end

    it "has a title link to the correct story/path" do
      @node = Node.where(title: @node.title).first
      assert page.has_link? @node.title, node_path(@node)
    end

    it "has story content on the story parent node view page" do
      @node = Node.where(title: @node.title).first
      click_link @node.title
      current_path.should eq "/nodes/#{@node.id}"
      assert page.has_content? @node.content
    end

  end

  context "when viewing a story's main page" do

    before(:each) do
      @node = Node.where(title: @node.title).first
      visit node_path(@node)
    end

    it "contains story information for the first node" do
      assert page.has_content? @node.title
      assert page.has_content? "Started by #{@user.name}"
      assert page.has_content? @node.content
    end

  end

  context "when reading a story chain" do

    before(:each) do
      @node = Node.where(title: @node.title).first
      visit story_path(@node)
    end

    it "contains story information for the existing node" do
      assert page.has_content? @node.title
      assert page.has_content? "Started by #{@user.name}"
      assert page.has_content? @node.content
    end

    it "contains a link to creating a new branch" do
      assert page.has_link? "Create a New Branch!", "/storiesnew/#{@node.id}"
    end

    it "allows the user to navigate to create a new branch of the existing node" do
      click_link "Create a New Branch!"
      assert page.has_content? @node.title
      assert page.has_content? "Continue the story!"
    end

  end

end

