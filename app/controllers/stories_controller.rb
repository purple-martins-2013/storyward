class StoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @book_nodes = Node.where(parent_node: 0)
    @book_nodes = @book_nodes.map {|node| {id: node.id}}
    @nodes = { children: @book_nodes }.to_json
  end

  def new
    @story = Story.new
    @story.build_node
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    @story.node = Node.new(node_params)
    @story.node.user = current_user
    if @story.save
      redirect_to @story, :notice => "#{@story.title} was created successfully."
    else
      render :new, :alert => "Story could not be saved. Please see the errors below."
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to @story, :notice => "#{@story.title} was updated succesfully."
    else
      render :update, :alert => "Updates could not be saved. Please see the errors below."
    end
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    redirect_to stories_path, :notice => "Story removed successfully."
  end

  private
  def story_params
    params.require(:story).permit(:title, node_attributes: [:id, :title, :content])
  end

  def node_params
    params.require(:node).permit(:title, :content)
  end
end
