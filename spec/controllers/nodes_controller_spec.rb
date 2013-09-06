require 'spec_helper'

describe NodesController do

  describe 'GET#index' do

    it 'returns an array of all nodes' do 
      nodes = []
      5.times {nodes << FactoryGirl.create(:node)}
      
      get :index
      assigns(:nodes).should eq(nodes)
    end

  end

end