module StoryHelper

  def find_stories_by_tag
    search_tags = params[:tag_tokens].split(",").map {|tag_id| tag_id.to_i }
    @found_stories = @found_stories.select {|story| (story.tags.map {|tag| tag.id} & search_tags).size > 0 }
    @found_stories.sort! do |a, b|
      comp = ((a.tags.map {|tag| tag.id} & search_tags).size <=> (b.tags.map {|tag| tag.id} & search_tags).size)
      comp.zero? ? (a.stars.length <=> b.stars.length) : comp
    end
    @found_stories = @found_stories.reverse
  end

  def find_by_title_author_content
    first_search = Story.where("title like ?", "%#{params[:search_bar]}%").sort_by {|story| story.stars.length }.reverse
    second_search = User.where("name like ?", "%#{params[:search_bar]}%").map {|user| user.stories}.flatten.sort_by {|story| story.stars.length }.reverse
    third_search = Node.where("content like ?", "%#{params[:search_bar]}%").map {|node| node.stories.first}.sort_by {|story| story.stars.length }.reverse
    @found_stories = first_search + second_search + third_search
end

end