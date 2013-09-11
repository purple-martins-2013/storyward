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
    current_path.should eq profile_path(@user)
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

  it "redirects you to the home page on unsuccessful login" do
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => "incorrect"
    page.find('.button').click
    current_path.should eq root_path
  end

end

describe "create story page" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click

    @node = FactoryGirl.build(:node)
    visit new_story_path
    page.fill_in "Title", :with => @node.title
  end

  context "when creating a story without upload" do

    before(:each) do
      fill_in "Content", :with => @node.content
      @story = FactoryGirl.create(:story)
      Story.stub(:find_by_id).and_return(@story)
      click_button("Create Story")
    end

    it "creates a new node" do
      Node.where(title: @node.title).length.should eq 1
    end

    it "redirects to the created story" do
      node = Node.where(title: @node.title).first
      current_path.should eq "/stories/#{node.id}"
    end

    it "contains content from the created story" do
      assert page.has_content? @node.content
    end

  end


  context "when creating a story with an upload" do

    before(:each) do
      attach_file("story_upload", File.expand_path("public/robots.txt"))
      @story = FactoryGirl.create(:story)
      Story.stub(:find_by_id).and_return(@story)
      click_button("Create Story")
    end

    it "creates a new node" do
      Node.where(title: @node.title).length.should eq 1
    end

    it "contains content from the uploaded file" do
      assert page.has_content? "documentation on how to use"
    end

  end


  context "when creating a story with both text upload and content entry" do

    before(:each) do
      fill_in "Content", :with => @node.content
      attach_file("story_upload", File.expand_path("public/robots.txt"))
      @story = FactoryGirl.create(:story)
      Story.stub(:find_by_id).and_return(@story)
      click_button("Create Story")
    end

    it "creates a new node" do
      Node.where(title: @node.title).length.should eq 1
    end

    it "contains content from both the uploaded file and the content entry" do
      assert page.has_content? "documentation on how to use"
      assert page.has_content? @node.content
    end

  end

  context "when creating a story with both pdf upload and content entry" do

    before(:each) do
      fill_in "Content", :with => @node.content
      attach_file("story_upload", File.expand_path("public/robots.pdf"))
      @story = FactoryGirl.create(:story)
      Story.stub(:find_by_id).and_return(@story)
      click_button("Create Story")
    end

    it "creates a new node" do
      Node.where(title: @node.title).length.should eq 1
    end

    it "contains content from both the uploaded file and the content entry" do
      assert page.has_content? "Challenges in Building Robots That Imitate People"
      assert page.has_content? @node.content
    end

  end

end

