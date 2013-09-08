class AddNodeIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :node_id, :integer
  end
end
