class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.belongs_to :user
      t.belongs_to :story
      t.string :title
      t.string :content
      t.integer :parent_node
      t.integer :children_nodes, :array => true, :default => []
      t.boolean :terminal

      t.timestamps
    end
  end
end
