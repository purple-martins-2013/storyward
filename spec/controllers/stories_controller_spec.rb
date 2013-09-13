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

    context "with a file upload" do
      
      it "accepts and parses a TXT file" do
        @file = fixture_file_upload('files/test.txt', 'text/txt')
        @node = FactoryGirl.attributes_for(:node, content: 'TEST')
        post :create, node: @node, :story => { title: 'test', :upload => @file, node: @node, user: FactoryGirl.attributes_for(:user) }
        expect(Story.last.node.content).to eq 'TEST TXT' + "\n" + 'TEST'
      end

      it "accepts and parses a PDF file" do
        @file = fixture_file_upload('files/test.pdf', 'application/pdf')
        @node = FactoryGirl.attributes_for(:node, content: 'TEST')
        post :create, node: @node, :story => { title: 'test', :upload => @file, node: @node, user: FactoryGirl.attributes_for(:user) }
        expect(Story.last.node.content).to eq ' TEST PDF' + ' TEST'
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
    it 'removes an entry from the database' do
      story
      expect{ delete :destroy, id: story }.to change(Story,:count).by(-1)
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
        search_term = @story.title.split(" ").drop(3).join(" ").upcase
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
