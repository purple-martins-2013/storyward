class CorrectNodesStoriesPluralization < ActiveRecord::Migration
  def change
    drop_table :nodes_stories

    create_table :nodes_stories do |t|
      t.references :node
      t.references :story
    end
  end
end
