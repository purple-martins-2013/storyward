class ChangeNodeContentType < ActiveRecord::Migration
  def change
    change_column :nodes, :content, :text
  end
end
