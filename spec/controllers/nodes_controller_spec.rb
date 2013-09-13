require 'spec_helper'

describe NodesController do

  before(:each) do
    @story = FactoryGirl.create(:story)
    @node = @story.node
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  describe 'GET#show' do
    it 'finds correct node' do
      get :show, :id => @node.id
      assigns(:node).should eq(@node)
    end
  end

  describe 'DELETE#destroy' do

    context "when incorrect user" do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        @node.user = nil
        @node.save
      end

      it 'redirects back with notice' do
        delete :destroy, :id => @node
        expect(response).to redirect_to("where_i_came_from")
        flash[:notice].should eq("This isn't your node!")
      end

      it 'does not delete the node' do
        expect{ delete :destroy, id: @node }.to change(Node,:count).by(0)
      end

    end
    
    context "when correct user is logged in" do

      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        @node.user = @user
        @node.save
      end

      it 'finds correct node' do
        delete :destroy, :id => @node.id
        assigns(:node).should eq(@node)
      end

      context 'it has children' do
        
        it 'redirects back with notice' do
          Node.stub(:find).and_return(@node)
          @node.stub(:children_nodes).and_return([1, 3, 4])

          delete :destroy, :id => @node.id
          expect(response).to redirect_to("where_i_came_from")
          flash[:notice].should eq("Node cannot be deleted because it has children.") 
        end
      end

      context 'it has no children' do
        before(:each) do
          Node.stub(:find).and_return(@node)
          @node.stub(:children_nodes).and_return([])
        end

        it 'deletes node' do 
          id = @node.id
          delete :destroy, :id => id
          Node.all.count.should eq(0)
        end

        it 'redirects to root' do
          delete :destroy, :id => @node.id
          expect(response).to redirect_to root_url
        end
      end

    end

  end

  describe 'query' do

    before(:each) do
      get :query, :id => @node.id
    end

    it "locates the created node" do
      assigns(:node).should eq @node
    end

    it "renders metadata json for the node" do
      @expected = { id: @node.id, title: @node.title, content: @node.content, author: @node.user.name }.to_json
      expect(response.body).to eq @expected
    end

  end

  describe 'details' do

    it "locates the created node" do
      get :details, :id => @node.id
      assigns(:node).should eq @node
    end

    it "renders first-level json given no children nodes" do
      @expected = { id: @node.id, author: @node.user.name}.to_json
      get :details, :id => @node.id
      expect(response.body).to eq @expected
    end

    it "renders nested json given a child node" do
      second_story = FactoryGirl.create(:story)
      second_node = second_story.node
      @node.children_nodes << second_node.id
      @node.children_nodes_will_change!
      @node.save
      second_node.parent_node = @node.id
      second_node.save

      @expected = {id: @node.id, author: @node.user.name, children: [ { id: second_node.id, author: second_node.user.name } ], size: 4.0 }.to_json
      get :details, :id => @node.id
      expect(response.body).to eq @expected
    end

  end

  describe 'chain' do

    it "locates the created node" do
      get :chain, :id => @node.id
      assigns(:node).should eq @node
    end

    it "renders first-level json with id, title, content and author" do
      @expected = [{ id: @node.id, title: @node.title, content: @node.content, author: @node.user.name }].to_json
      get :chain, :id => @node.id
      expect(response.body).to eq @expected
    end

    it "renders chained json given a child node" do
      second_story = FactoryGirl.create(:story)
      second_node = second_story.node
      @node.children_nodes << second_node.id
      @node.children_nodes_will_change!
      @node.save
      second_node.parent_node = @node.id
      second_node.save

      @expected = [{ id: @node.id, title: @node.title, content: @node.content, author: @node.user.name }, { id: second_node.id, title: second_node.title, content: second_node.content, author: second_node.user.name }].to_json
      get :chain, :id => second_node.id
      expect(response.body).to eq @expected
    end

  end
end
