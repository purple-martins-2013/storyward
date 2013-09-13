class AddParentsArrayToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :parent_path, :integer, array: true, default: []
  end
end
