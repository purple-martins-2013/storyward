require 'spec_helper'

describe StoriesController do
  render_views

  let(:user){ FactoryGirl.create(:user) }
  let(:story){ FactoryGirl.create(:story) }
  let(:node){ FactoryGirl.create(:node) }

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

    it 'creates a corresponding node' do
      expect { post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node) }.to change(Node,:count).by(1)
    end

    context 'node/story relationships' do

      before(:each) do
        post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node)
      end

      it 'links the story and node to the current user' do
        assigns(:story).user.should eq user
        assigns(:story).node.user.should eq user
      end

      it "assigns the node's title to the story title" do
        assigns(:story).title.should eq assigns(:story).node.title
      end

      it "assigns the story's node a parent_node of 0 as specified" do
        assigns(:story).node.parent_node.should eq 0
      end

      it "assigns the story's node an actual parent_node, and the parent_node its children_node, when specified" do
        new_node_attributes = FactoryGirl.attributes_for(:node)
        new_node_attributes[:parent_node] = Node.first.id

        post :create, story: FactoryGirl.attributes_for(:story), node: new_node_attributes
        Node.first.children_nodes.length.should eq 1
        Node.first.children_nodes.first.should eq Node.last.id
      end

      it 'with invalid params' do
        post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node, title: '')
        response.should render_template('new')
      end

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

  describe '#show' do
    it 'finds the right story' do
      get :show, id: story
      assigns(:story).should eq(story)
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

  describe "#search" do

    it "returns an empty search when no search terms are entered" do
      post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node)
      post :search, search_bar: "", tag_tokens: ""
      assigns(:found_stories).should eq []
    end

    context "tag search" do

      before(:each) do
        ActsAsTaggableOn::Tag.create(name: "taggy")
        ActsAsTaggableOn::Tag.create(name: "checkitout")
        ActsAsTaggableOn::Tag.create(name: "waterpool")

        post :create, story: {tag_list: ActsAsTaggableOn::Tag.all.map {|tag| tag.name}.join(",")}, node: FactoryGirl.attributes_for(:node)
        @story = assigns(:story)
      end
      
      it "returns no results when no tags match" do
        new_tag = ActsAsTaggableOn::Tag.create(name: "newtag")
        post :search, search_bar: "", tag_tokens: new_tag.id.to_s
        assigns(:found_stories).should eq []
      end

      it "returns the correct result when tags match" do
        matching_tag = ActsAsTaggableOn::Tag.find_by(name: "checkitout")
        post :search, search_bar: "", tag_tokens: matching_tag.id.to_s
        assigns(:found_stories).should eq [@story]
      end

      it "ranks a story with more tag matches more highly" do
        story_three = @story

        post :create, story: {tag_list: ActsAsTaggableOn::Tag.all.drop(1).map {|tag| tag.name}.join(",")}, node: FactoryGirl.attributes_for(:node)
        story_two = assigns(:story)
        
        post :create, story: {tag_list: ActsAsTaggableOn::Tag.all.drop(2).map {|tag| tag.name}.join(",")}, node: FactoryGirl.attributes_for(:node)
        story_one = assigns(:story)

        tag_one = ActsAsTaggableOn::Tag.find_by(name: "taggy")
        tag_two = ActsAsTaggableOn::Tag.find_by(name: "checkitout")
        tag_three = ActsAsTaggableOn::Tag.find_by(name: "waterpool")
        
        post :search, search_bar: "", tag_tokens: "#{tag_one.id},#{tag_two.id},#{tag_three.id}"
        assigns(:found_stories).should eq [story_three, story_two, story_one]
      end

    end

    context "title/author/content search" do

      before(:each) do
        post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node)
        @story = assigns(:story)
      end

      it "returns no results if there are no matches" do
        search_term = "zzyxyzyzyx"
        post :search, search_bar: search_term, tag_tokens: ""
        assigns(:found_stories).should eq []
      end

      it "allows for search by title" do
        search_term = @story.title
        post :search, search_bar: search_term, tag_tokens: ""
        assigns(:found_stories).should eq [@story]
      end

      it "allows for search by author" do
        search_term = @story.user.name.split(" ").sample
        post :search, search_bar: search_term, tag_tokens: ""
        assigns(:found_stories).should eq [@story]
      end

      it "allows for search by content" do
        search_term = @story.node.content.split(" ").drop(20).join(" ")
        post :search, search_bar: search_term, tag_tokens: ""
        assigns(:found_stories).should eq [@story]
      end

      it "allows for fuzzy search" do
        search_term = @story.title.upcase
        post :search, search_bar: search_term, tag_tokens: ""
        assigns(:found_stories).should eq [@story]
      end

    end

    context "mixed searches" do

      before(:each) do
        ActsAsTaggableOn::Tag.create(name: "taggy")
        ActsAsTaggableOn::Tag.create(name: "checkitout")
        ActsAsTaggableOn::Tag.create(name: "waterpool")

        post :create, story: {tag_list: ActsAsTaggableOn::Tag.all.map {|tag| tag.name}.join(",")}, node: {title: "Chihuahua Dance", content: "Sample", parent_node: 0}
        @story_one = assigns(:story)
        post :create, story: {tag_list: ActsAsTaggableOn::Tag.all.drop(1).map {|tag| tag.name}.join(",")}, node: {title: "Teenage Mutant Ninja Turtles", content: "Sample 2", parent_node: 0}
        @story_two = assigns(:story)
      end

      it "will give precedence to search by title, author or content by not returning non-matching results" do
        search_term = "ninja turtles"
        matching_tag = ActsAsTaggableOn::Tag.find_by(name: "checkitout")
        post :search, search_bar: search_term, tag_tokens: matching_tag.id.to_s
        assigns(:found_stories).should eq [@story_two]
      end

      it "will revert to tag matching if there are no title/author/content matches" do
        search_term = "zzyxyzyzyx"
        tag_one = ActsAsTaggableOn::Tag.find_by(name: "taggy")
        tag_two = ActsAsTaggableOn::Tag.find_by(name: "checkitout")
        tag_three = ActsAsTaggableOn::Tag.find_by(name: "waterpool")
        post :search, search_bar: search_term, tag_tokens: "#{tag_one.id},#{tag_two.id},#{tag_three.id}"
        assigns(:found_stories).should eq [@story_one, @story_two]        
      end

    end
  end

end
