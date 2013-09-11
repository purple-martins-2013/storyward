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
