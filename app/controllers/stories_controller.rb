class StoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @book_nodes = Node.where(parent_node: 0).order("ARRAY_LENGTH(children_nodes, 1) DESC")
    #@book_nodes = @book_nodes.sort_by {|node| node.children_nodes.length }.reverse
    @book_nodes = @book_nodes.map {|node| {id: node.id}}
    @nodes = { children: @book_nodes }.to_json
    @tags = ActsAsTaggableOn::Tag.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @tags.where("name like ?", "%#{params[:q]}%") }
    end
  end

  def new
    @parent_node = params[:id] if params[:id]
    @story = Story.new
    @story.build_node
  end

  def show 
   @story = Story.find(params[:id])
  end

  def create
    story_params = {}
    process_upload
    story_params[:title] = node_params[:title]
    @story = Story.new(story_params)
    @story.user = current_user
    create_nodes
    @story.tag_list = params[:story][:tag_list]
    if @story.save
      redirect_to story_path(@story), :notice => "#{@story.title} was created successfully."
    else
      render :new, :alert => "Story could not be saved. Please see the errors below."
    end
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    redirect_to stories_path, :notice => "Story removed successfully."
  end

  def search
    if params[:search_bar] != ""
      find_by_title_author_content
      if params[:tag_tokens] != ""
        @found_stories = Story.all if @found_stories == []
        find_stories_by_tag
      end
    else
      if params[:tag_tokens] != ""
        @found_stories = Story.all
        find_stories_by_tag
      else
        @found_stories = []
      end
    end
  end

  private

  def node_params
    params.require(:node).permit(:title, :content, :parent_node)
  end
end
