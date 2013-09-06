require 'spec_helper'

describe StoriesController do
  render_views

  let(:user){ FactoryGirl.build(:user) }

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
      Story.should_receive(:create).with({:title => 'Sample', tail_node: 1}.with_indifferent_access)
      post :create, story: {title: 'Sample', tail_node: 1}
    end
  end


end
