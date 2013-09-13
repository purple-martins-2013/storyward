require "spec_helper"

describe "update story page" do

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
    @original_id = current_path.split("/").last

    visit edit_story_path(@original_id)
    page.fill_in "Title", :with => "Chihuahua"
  end

  context "when updating a story without upload" do

    before(:each) do
      fill_in "Content", :with => "Raising bunnies"
      click_button("Update Story")
    end

    it "does not create a new node" do
      Node.where(title: @node.title).length.should eq 0
      updated_node = Node.where(title: "Chihuahua")
      updated_node.length.should eq 1
      updated_node.first.id.should eq @original_id.to_i
    end

    it "redirects to the updated story" do
      node = Node.where(title: "Chihuahua").first
      current_path.should eq "/stories/#{node.id}"
    end

    it "contains content from the created story" do
      assert page.has_content? "Raising bunnies"
    end

  end


  context "when creating a story with an upload" do

    before(:each) do
      attach_file("story_upload", File.expand_path("public/robots.txt"))
      click_button("Update Story")
    end

    it "returns you to the edit story page" do
      current_path.should eq story_path(@original_id)
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "documentation on how to use"
      fill_in "Content", :with => ""
      assert page.has_no_content? "documentation on how to use"
    end

    it "does not create a new node after resubmitting" do
      click_button("Update Story")
      Node.where(title: @node.title).length.should eq 0
      updated_node = Node.where(title: "Chihuahua")
      updated_node.length.should eq 1
      updated_node.first.id.should eq @original_id.to_i
    end

    it "updates with content from the uploaded file" do
      click_button("Update Story")
      assert page.has_content? "documentation on how to use"
    end

  end


  context "when creating a story with both text upload and content entry" do

    before(:each) do
      fill_in "Content", :with => "Raising bunnies"
      attach_file("story_upload", File.expand_path("public/robots.txt"))
      click_button("Update Story")
    end

    it "returns you to the edit story page" do
      node = Node.where(title: "Chihuahua").first
      current_path.should eq story_path(@original_id)
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "documentation on how to use"
      assert page.has_content? "Raising bunnies"
      fill_in "Content", :with => ""
      assert page.has_no_content? "documentation on how to use"
      assert page.has_no_content? "Raising bunnies"
    end

    it "does not create a new node after resubmitting" do
      click_button("Update Story")
      Node.where(title: @node.title).length.should eq 0
      updated_node = Node.where(title: "Chihuahua")
      updated_node.length.should eq 1
      updated_node.first.id.should eq @original_id.to_i
    end

    it "contains content from both the uploaded file and the content entry" do
      click_button("Update Story")
      assert page.has_content? "documentation on how to use"
      assert page.has_content? "Raising bunnies"
    end

  end

  context "when creating a story with both pdf upload and content entry" do

    before(:each) do
      fill_in "Content", :with => "Raising bunnies"
      attach_file("story_upload", File.expand_path("public/robots.pdf"))
      click_button("Update Story")
    end

    it "returns you to the edit story page" do
      node = Node.where(title: "Chihuahua").first
      current_path.should eq story_path(@original_id)
    end

    it "puts content from the uploaded file into Content field" do
      assert page.has_content? "Challenges in Building Robots That Imitate People"
      assert page.has_content? "Raising bunnies"
      fill_in "Content", :with => ""
      assert page.has_no_content? "Challenges in Building Robots That Imitate People"
      assert page.has_no_content? "Raising bunnies"
    end

    it "does not create a new node after resubmitting" do
      click_button("Update Story")
      Node.where(title: @node.title).length.should eq 0
      updated_node = Node.where(title: "Chihuahua")
      updated_node.length.should eq 1
      updated_node.first.id.should eq @original_id.to_i
    end

    it "contains content from both the uploaded file and the content entry" do
      click_button("Update Story")
      assert page.has_content? "Challenges in Building Robots That Imitate People"
      assert page.has_content? "Raising bunnies"
    end

  end

end