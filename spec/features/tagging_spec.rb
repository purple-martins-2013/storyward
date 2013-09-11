require "spec_helper"
	
describe "story creation page" do

	before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    page.fill_in "Email", :with => @user.email
    page.fill_in "Password", :with => @user.password
    page.find('.button').click
  end

  context "when story is created with tags" do

  	before(:each) do
	  	visit new_story_path
	  	page.fill_in "Title", :with => 'Test Title'
	  	page.fill_in "Content", :with => 'Test Content'
	  	@story = FactoryGirl.create(:story)
    	Story.stub(:find_by_id).and_return(@story)
	  end


	  context "when the tags are different" do
		  it "should downcase the tags" do
		  	page.fill_in "Tag list (separated by commas)", :with => 'gOoD, BaD'
		  	click_button 'Create Story'
		  	@story = Story.last
		  	expect(@story.tag_list).to eq ['bad', 'good']
		  end

		  it "should assign the tags to the story" do
		  	page.fill_in "Tag list (separated by commas)", :with => 'good, bad'
		  	click_button 'Create Story'
		  	@story = Story.last
		  	expect(@story.tag_list).to eq ['bad', 'good']
	  	end
	  end

	  context "when the tags are the same" do
	  	it "should only assign one tag" do
		  	page.fill_in "Tag list (separated by commas)", :with => 'good, good'
		  	click_button 'Create Story'
		  	@story = Story.last
		  	expect(@story.tag_list).to eq ['good']
		  end

	  	it "should downcase the one tag" do
		  	page.fill_in "Tag list (separated by commas)", :with => 'gOoD, GoOd'
		  	click_button 'Create Story'
		  	@story = Story.last
		  	expect(@story.tag_list).to eq ['good']
		  end
	  end
	end
end