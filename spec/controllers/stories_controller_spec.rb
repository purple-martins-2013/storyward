require 'spec_helper'

describe StoriesController do
  render_views

  let(:user){ FactoryGirl.create(:user) }
  let(:story){ FactoryGirl.create(:story) }

  before(:each) do 
    sign_in user
  end

  describe '#create' do
    it 'creates a story' do
      expect { post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node) }.to change(Story,:count).by(1)
    end

    it "shows a notice when story creation succeeds" do
      new_node = FactoryGirl.attributes_for(:node)
      post :create, story: FactoryGirl.attributes_for(:story), node: new_node
      flash[:notice].should eq("#{new_node[:title]} was created successfully.")
    end

    it 'will show an alert if story creation fails' do
      node_without_title = FactoryGirl.attributes_for(:node)
      node_without_title[:title] = ""
      post :create, story: FactoryGirl.attributes_for(:story), node: node_without_title
      flash[:alert].should eq("Story could not be saved. Please see the errors below.")
      Node.all.length.should eq 0
    end

  end

  describe "#update" do

    context "correct user" do

      before(:each) do
        story.user = user
        story.save
      end
      
      it "updates a story" do
        post :update, id: story, story: {}, node: {title: "Whistling Hounds", content: "Minified!", parent_node: 0}
        story = Story.first
        story.title.should eq "Whistling Hounds"
        story.node.content.should eq "Minified!"
      end

      it "shows a notice when the story update succeeds" do
        post :update, id: story, story: {}, node: {title: "Whistling Hounds", content: "Minified!", parent_node: 0}
        revised_story = Story.first
        flash[:notice].should eq("#{revised_story.title} was updated successfully.")
      end

      it "will not update the story if the story update fails" do
        post :update, id: story, story: {}, node: {title: "", content: "Minified!", parent_node: 0}
        story = Story.first
        story.title.should_not eq ""
        story.node.content.should_not eq "Minified!"
      end

    end

    context "incorrect user" do

      before(:each) do
        post :update, id: story, story: FactoryGirl.attributes_for(:story), node: {title: "Whistling Hounds", content: "Minified!", parent_node: 0}
      end

      it "refuses to update a story if the incorrect user is logged in" do
        story = Story.first
        story.title.should_not eq "Whistling Hounds"
        story.node.content.should_not eq "Minified!"
      end

      it "provides an alert if the user is incorrect" do
        flash[:notice].should eq("You don't own this part of the story!")
      end

    end
    
  end

  describe "#delete" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it 'will not remove a story that does not belong to the current user' do
      story
      expect{ delete :destroy, id: story }.to change(Story,:count).by(0)
      flash[:notice].should eq("You don't own this story!")
    end

    it 'will remove a story that belongs to the current user' do
      story
      story.user = user
      story.save
      expect{ delete :destroy, id: story }.to change(Story,:count).by(-1)
      flash[:notice].should eq("Story removed successfully.")
    end

    it "will not remove a story that has children nodes" do
      story
      story.user = user
      story.save
      story.node.children_nodes << 5
      story.node.children_nodes_will_change!
      story.node.save
      expect{ delete :destroy, id: story }.to change(Story,:count).by(0)
      flash[:notice].should eq("This story has branches, and unfortunately cannot be deleted.")
    end

  end

end
