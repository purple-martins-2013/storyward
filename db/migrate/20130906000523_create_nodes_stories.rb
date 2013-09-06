class CreateNodesStories < ActiveRecord::Migration
  def change
    create_table :nodes_stories do |t|
      t.references :nodes
      t.references :stories
    end
  end
end
