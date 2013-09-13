class ApplicationController < ActionController::Base
  include NodeHelper
  include StoryHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :update_sanitized_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    profile_path(resource.id)
  end

	def update_sanitized_params
	  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
	end

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      false
    else
      "application"
    end
  end
end
