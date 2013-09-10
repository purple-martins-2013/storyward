class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user!
  
  def welcome
  	if current_user
  		redirect_to profile_path(current_user)
  	end
  end
  
end
