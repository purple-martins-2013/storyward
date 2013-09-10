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
  end
end
