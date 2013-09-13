require "spec_helper"

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
      click_button("Create Story")
    end

    it "returns you to the create story page" do
      current_path.should eq stories_path
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "documentation on how to use"
      fill_in "Content", :with => ""
      assert page.has_no_content? "documentation on how to use"
    end

    it "creates a new node after resubmitting" do
      click_button("Create Story")
      Node.where(title: @node.title).length.should eq 1
    end

    it "creates a node containing content from the uploaded file" do
      click_button("Create Story")
      assert page.has_content? "documentation on how to use"
    end

  end


  context "when creating a story with both text upload and content entry" do

    before(:each) do
      fill_in "Content", :with => @node.content
      attach_file("story_upload", File.expand_path("public/robots.txt"))
      click_button("Create Story")
    end

    it "returns you to the create story page" do
      current_path.should eq stories_path
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "documentation on how to use"
      assert page.has_content? @node.content
      fill_in "Content", :with => ""
      assert page.has_no_content? "documentation on how to use"
      assert page.has_no_content? @node.content
    end

    it "creates a new node after resubmitting" do
      click_button("Create Story")
      Node.where(title: @node.title).length.should eq 1
    end

    it "contains content from both the uploaded file and the content entry" do
      click_button("Create Story")
      assert page.has_content? "documentation on how to use"
      assert page.has_content? @node.content
    end

  end

  context "when creating a story with both pdf upload and content entry" do

    before(:each) do
      fill_in "Content", :with => @node.content
      attach_file("story_upload", File.expand_path("public/robots.pdf"))
      click_button("Create Story")
    end

    it "returns you to the create story page" do
      current_path.should eq stories_path
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "Challenges in Building Robots That Imitate People"
      assert page.has_content? @node.content
      fill_in "Content", :with => ""
      assert page.has_no_content? "Challenges in Building Robots That Imitate People"
      assert page.has_no_content? @node.content
    end

    it "creates a new node after resubmitting" do
      click_button("Create Story")
      Node.where(title: @node.title).length.should eq 1
    end

    it "contains content from both the uploaded file and the content entry" do
      click_button("Create Story")
      assert page.has_content? "Challenges in Building Robots That Imitate People"
      assert page.has_content? @node.content
    end
    
  end

end