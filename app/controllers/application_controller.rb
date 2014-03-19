class ApplicationController < ActionController::Base
	protect_from_forgery
	helper_method :current_user
	before_filter :debuggy

	def handle_error
		redirect_to error_path
	end

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, alert: exception.message
	end

	rescue_from ActionView::MissingTemplate do |e|
		render "error/index", status: 404
	end

	def debuggy
		@print_debug = true
		@debug_string = Digest::MD5.hexdigest(
		                                      "{ \"" +
		                                      (current_user ? current_user.name : "NOT LOGGED IN" ) +
		                                      "\", \"" +
		                                      (@print_debug ? "true" : "false") +
		                                      "\" };")
	end

	private
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
