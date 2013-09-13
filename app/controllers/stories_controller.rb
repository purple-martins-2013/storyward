class StoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @books = Node.where(parent_node: 0).order("ARRAY_LENGTH(children_nodes, 1) DESC")
    @book_nodes = @books.map {|node| {id: node.id}}
    @stories = @books.map {|book| book.stories.first }
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
    @story_params = {}
    process_upload
    if params[:story] && params[:story][:upload]
      upload_into_content
      flash.now[:success] = "File uploaded!  Please edit for formatting as you see fit."
      render :new
    else
      create_story
      create_nodes
      if @story.save
        @parent_node.save if @parent_node
        redirect_to story_path(@story.node), :notice => "#{@story.title} was created successfully."
      else
        @story.node.destroy
        flash.now[:alert] = "Story could not be saved. Please see the errors below."
        render :new
      end
    end
  end

  def edit
    @story = Node.find(params[:id]).stories.first
    populate_edit_fields
  end

  def update
    @story_params = {}
    @story = Story.find(params[:id])
    if @story.user == current_user
      process_upload
      if params[:story] && params[:story][:upload]
        edit_page_upload
        flash.now[:success] = "File uploaded!  Please edit for formatting as you see fit."
        render :edit
      else
        update_story
        update_node
        if @story.update_attributes(@story_params)
          redirect_to story_path(@story.node), :notice => "#{@story.title} was updated successfully."
        else
          render :edit, :alert => "Updates could not be saved. Please see the errors below."
        end
      end
    else
      redirect_to profile_path(current_user), :notice => "You don't own this part of the story!"
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
        redirect_to root_path, :notice => "Story removed successfully."
      end
    else
      redirect_to :back, :notice => "You don't own this story!"
    end
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
