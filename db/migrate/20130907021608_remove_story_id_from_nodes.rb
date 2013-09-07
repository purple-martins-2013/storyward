class RemoveStoryIdFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :story_id
  end
end
