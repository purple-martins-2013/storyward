class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :tail_node
      t.references :user
      t.references :nodes
    end
  end
end
