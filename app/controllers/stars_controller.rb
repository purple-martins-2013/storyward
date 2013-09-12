class StarsController < ApplicationController

  def create
    Star.create(user: current_user, story_id: params[:story_id] )
    @story = Story.find_by_id(params[:story_id])
    render 'stories/_bookmark', :layout => false
  end

  def destroy
    Star.where(user: current_user, story_id: params[:story_id] ).first.destroy
    @story = Story.find_by_id(params[:story_id])
    render 'stories/_bookmark', :layout => false
  end

end