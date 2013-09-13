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
      node = FactoryGirl.create(:node, :content => '<script type="text/javascript">alert("foo!");</script>A Message')
      node.save
      expect(node.content).to eq('alert("foo!");A Message')
    end

    it "builds parent node path" do
      node1 = FactoryGirl.create(:node)
      expect(node1.parent_path).to eq []
      node2 = FactoryGirl.create(:node, parent_node: node1.id)
      expect(node2.parent_path).to eq [node1.id]
    end
  end
end
