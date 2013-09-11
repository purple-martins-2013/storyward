class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @parent_stories = @user.nodes.where(parent_node: 0)
    @children_nodes = @user.nodes - @parent_stories
  end
end
