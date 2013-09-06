class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      redirect_to @story
    else
      render :new
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to @story
    else
      render :update
    end
  end

  private
  def story_params
    params.require(:story).permit(:title, :tail_node)
  end
end
