class ApplicationController < ActionController::Base
  include NodeHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
    profile_path(resource.id)
  end
end
