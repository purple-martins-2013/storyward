class RemoveNodesIdAndTailnodesFromStories < ActiveRecord::Migration
  def change
    remove_column :stories, :nodes_id
    remove_column :stories, :tail_node
  end
end
