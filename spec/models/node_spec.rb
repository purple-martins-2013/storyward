require 'spec_helper'

describe Node do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:parent_node) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:stories) }
  end

  describe "on create" do
    it "should set default children nodes to an empty array" do
      node = Node.new
      expect(node.children_nodes).to eq []
    end
  end
end
