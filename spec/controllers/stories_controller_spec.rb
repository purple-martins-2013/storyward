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

    it 'with invalid params' do
      post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node, title: '')
      response.should render_template('new')
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

  describe '#search' do
    before do
      story.tag_list = 'test'
      story.save
    end

    it 'should return the story with the tag searched' do
      post :search, :search_bar => story.tag_list.first
      assigns(:stories).should include(story)
    end

    it 'should return the stories written by the author searched' do
      post :search, :search_bar => story.user.name
      assigns(:stories).should include(story)
    end

    it 'should return the stories of the title searched' do
      post :search, :search_bar => story.title
      assigns(:stories).should include(story)
    end

  end
end
