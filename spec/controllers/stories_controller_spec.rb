require 'spec_helper'

describe StoriesController do
  render_views

  let(:user){ FactoryGirl.create(:user) }
  let(:story){ FactoryGirl.create(:story) }

  before(:each) do 
    sign_in user
  end

  describe "#index" do
    it "populates a list of stories" do
      get :index
      expect(assigns(:stories)).to eq([story])
    end
  end

  describe '#create' do
    it 'creates a story' do
      expect { post :create, story: FactoryGirl.attributes_for(:story), node: FactoryGirl.attributes_for(:node) }.to change(Story,:count).by(1)
    end
  end

  describe '#update' do
    it 'modifies a story in the database' do
      put :update, id: story, story: FactoryGirl.attributes_for(:story, title: "FooBar")
      story.reload
      story.title.should eq("FooBar")
    end
  end

  describe "#delete" do
    it 'removes an entry from the database' do
      story
      expect{ delete :destroy, id: story }.to change(Story,:count).by(-1)
    end
  end
end
