require 'spec_helper'

describe Node do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:stories) }
  end

  describe "on create" do
    it "should set default children nodes to an empty array" do
      node = Node.new
      expect(node.children_nodes).to eq []
    end

    it "should sanitize HTML content" do
      node = FactoryGirl.create(:story).node
      node.content = '<script type="text/javascript">alert("foo!");</script>A Message'
      node.save
      expect(node.content).to eq('alert("foo!");A Message')
    end

    it "builds parent node path" do
      node1 = FactoryGirl.create(:story).node
      expect(node1.parent_path).to eq []

      node_attributes = FactoryGirl.attributes_for(:node)
      node_attributes[:parent_node] = node1.id
      story_attributes = FactoryGirl.attributes_for(:story)
      story_attributes[:node] = Node.create(node_attributes)
      story_attributes[:user] = FactoryGirl.create(:user)
      new_story = Story.create(story_attributes)

      node2 = new_story.node
      expect(node2.parent_path).to eq [node1.id]
    end
  end
end
