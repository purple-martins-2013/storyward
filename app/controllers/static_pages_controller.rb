class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user!
  
  def welcome
    @book_nodes = Node.where(parent_node: 0)
    @book_nodes = @book_nodes.map {|node| {id: node.id}}
    @nodes = { children: @book_nodes }.to_json
  end
end
