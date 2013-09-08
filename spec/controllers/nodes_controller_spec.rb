require 'spec_helper'

describe NodesController do

  let(:story_id) { 1 }
  let(:node_id) { 1 }
  let(:node) { FactoryGirl.create(:node) }
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_params) { FactoryGirl.attributes_for(:node) }

  before(:each) do
    sign_in(user)
  end

  describe 'GET#show' do
    it 'finds correct node' do
      get :show, :story_id => story_id, :id => node.id
      assigns(:node).should eq(node)
    end
  end

  describe 'GET#edit' do
    it 'finds correct node' do
      get :edit, :story_id => story_id, :id => node.id
      assigns(:node).should eq(node)
    end
  end

  describe 'PUT#update' do
    it 'finds correct node' do
      put :update, :id => node.id, node: (valid_params)
      assigns(:node).should eq(node)
    end

    context 'it has children' do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      it 'redirects back with notice' do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([1, 3, 4])

        put :update, :story_id => story_id, :id => node.id, node: (valid_params)
        expect(response).to redirect_to("where_i_came_from")
        flash[:notice].should eq("Node cannot be edited because it has children.") 
      end
    end

    context 'it has no children' do
      before(:each) do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([])
      end

      it 'updates node with params' do 
        put :update, :story_id => story_id, :id => node.id, node: (valid_params)
      end

      it 'redirects to show path' do
        put :update, :story_id => story_id, :id => node.id, node: (valid_params)
        expect(response).to redirect_to node
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'finds correct node' do
      delete :destroy, :story_id => story_id, :id => node.id
      assigns(:node).should eq(node)
    end

    context 'it has children' do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      it 'redirects back with notice' do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([1, 3, 4])

        delete :destroy, :story_id => story_id, :id => node.id
        expect(response).to redirect_to("where_i_came_from")
        flash[:notice].should eq("Node cannot be deleted because it has children.") 
      end
    end

    context 'it has no children' do
      before(:each) do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([])
      end

      it 'deletes node' do 
        id = node.id
        delete :destroy, :story_id => story_id, :id => id
        Node.all.count.should eq(0)
      end

      it 'redirects to root' do
        delete :destroy, :story_id => story_id, :id => node.id
        expect(response).to redirect_to root_url
      end
    end

  end
end
