require 'spec_helper'

describe NodesController do

  let(:story_id) { 1 }
  let(:node_id) { 1 }
  let(:node) { FactoryGirl.create(:node) }
  let(:valid_params) { FactoryGirl.attributes_for(:node) }

  describe 'GET#index' do

    it 'returns an array of all nodes' do 
      nodes = []
      5.times {nodes << FactoryGirl.create(:node)}
      
      get :index
      assigns(:nodes).should eq(nodes)
    end
  end

  describe 'GET#new' do
    it 'makes a new node' do
      get :new, :story_id => story_id

      assigns(:node).should be_new_record
    end
  end
  #/users/:user_id/nodes
  describe 'POST#create' do

    context 'with correct params' do     
      let(:valid_params) { FactoryGirl.attributes_for(:node) }

      it 'saves the node into the database' do
        post :create, :story_id => story_id, node: (valid_params)
        Node.all.count.should eq(1)
      end

      it 'redirects to node' do
        Node.any_instance.stub(:id).and_return(node_id)
        post :create, :story_id => story_id, node: (valid_params)
        expect(response).to redirect_to story_node_path(story_id, node_id)
      end
    end

    context 'with incorrect params' do

      let(:invalid_params) { {:title=>"", :content=>"", :parent_node=>1}}
      
      it 'does not save the node into the database' do
        post :create, :story_id => 1, node: (invalid_params)
        Node.all.count.should eq(0)
      end

      it 'renders new view' do
        post :create, :story_id => story_id, node: (invalid_params)
        should render_template(:new)
      end
    end
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
      put :update, :story_id => story_id, :id => node.id, node: (valid_params)
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
        expect(response).to redirect_to story_node_path(story_id, node.id)
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'finds correct node' do
      delete :destroy, :story_id => story_id, :id => node.id #, node: (valid_params)
      assigns(:node).should eq(node)
    end

    context 'it has children' do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      it 'redirects back with notice' do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([1, 3, 4])

        delete :destroy, :story_id => story_id, :id => node.id, node: (valid_params)
        expect(response).to redirect_to("where_i_came_from")
        flash[:notice].should eq("Node cannot be edited because it has children.") 
      end
    end

    context 'it has no children' do
      before(:each) do
        Node.stub(:find).and_return(node)
        node.stub(:children_nodes).and_return([])
      end

      it 'deletes node' do 
        delete :destroy, :story_id => story_id, :id => node.id, node: (valid_params)
        expect(Node.find(node.id)).to be_nil
      end

      it 'redirects to show path' do
        delete :destroy, :story_id => story_id, :id => node.id, node: (valid_params)
        expect(response).to redirect_to story_node_path(story_id, node.id)
      end
    end
  end
end