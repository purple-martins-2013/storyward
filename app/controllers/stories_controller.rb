class StoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @book_nodes = Node.where(parent_node: 0)
    @book_nodes = @book_nodes.sort_by {|node| node.children_nodes.length }.reverse
    @book_nodes = @book_nodes.map {|node| {id: node.id}}
    @nodes = { children: @book_nodes }.to_json
  end

  def new
    @parent_node = params[:id] if params[:id]
    @story = Story.new
    @story.build_node
  end

  def show 
    @node = Node.find(params[:id])
    @story = build_chain(@node).reverse
  end

  def create
    story_params = {}
    process_upload
    if params[:story] && params[:story][:upload]
      @saved_title = params[:node][:title]
      @uploaded_content = params[:node][:content]
      @saved_tags = params[:story][:tag_list]
      @parent_node = params[:node][:parent_node] if params[:node][:parent_node] != "0"
      @story = Story.new
      @story.build_node
      flash.now[:success] = "File uploaded!  Please edit for formatting as you see fit."
      render :new
    else
      story_params[:title] = node_params[:title]
      @story = Story.new(story_params)
      @story.user = current_user
      create_nodes
      @story.tag_list = params[:story][:tag_list]
      if @story.save
        redirect_to story_path(@story.node), :notice => "#{@story.title} was created successfully."
      else
        flash.now[:alert] = "Story could not be saved. Please see the errors below."
        render :new
      end
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(node_params)
      redirect_to @story, :notice => "#{@story.title} was updated succesfully."
    else
      render :update, :alert => "Updates could not be saved. Please see the errors below."
    end
  end

  def destroy
    story = Story.find(params[:id])
    if story.user == current_user
      if story.node.children_nodes.length > 0
        redirect_to :back, :notice => "This story has branches, and unfortunately cannot be deleted."
      else
        story.node.destroy
        story.destroy
        redirect_to stories_path, :notice => "Story removed successfully."
      end
    else
      redirect_to :back, :notice => "You don't own this story!"
    end
  end

  private

  def node_params
    params.require(:node).permit(:title, :content, :parent_node)
  end
end
