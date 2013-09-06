require 'spec_helper'

describe StoriesController do
  render_views
  describe '#create' do
    it 'creates a story' do
      Story.should_receive(:create).with({:title => 'Sample', tail_node: 1}.with_indifferent_access)
      post :create, user: {title: 'Sample', tail_node: 1}
    end
  end
end
