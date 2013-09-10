RSpec.configure do |config|
  config.include Warden::Test::Helpers
  Warden.test_mode!
end

require "spec_helper"

describe "create story page" do
  
  before(:each) do
    user = FactoryGirl.create(:user)
    user.confirmed_at = Time.now
    user.save
    login_as(user, :scope => :user, :run_callbacks => false)
    @node = FactoryGirl.build(:node)
    visit new_story_path
    page.fill_in "Title", :with => @node.title
  end

  after(:each) do
    Warden.test_reset!
  end

  context "when creating a story without upload" do

    before(:each) do
      fill_in "Content", :with => @node.content
      page.click_link "Create Story"
    end

    it "creates a new node" do
      Node.where(title: @node.title).length.should eq 1
    end

    it "redirects to the created story" do
      node = Node.where(title: @node.title).first
      current_path.should eq "http://www.example.com/stories/#{node.id}"
    end

  end


  context "when creating a story with an upload" do

    it "creates a new node" do

    end

    it "contains content from the uploaded file" do

    end

  end


  context "when creating a story with both upload and content entry" do

    it "creates a new node" do

    end

    it "contains content from both the uploaded file and the content entry" do

    end

  end

end

