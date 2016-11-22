class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery :exception => :receive_guest
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
  	if current_user
  		if session[:guest_user_id] && session[:guest_user_id] != current_user.id
  			logging_in
  			# reload guest_user to prevent caching problems before destruction
  			guest_user(with_retry = false).reload.try(:destroy)
  			session[:guest_user_id] = nil
  		end
  		current_user
  	elsif (!is_guest_user?)
  		guest_user
  	else
  		User.new
  	end
  end
  helper_method :current_or_guest_user, :is_guest_user?

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
  	# Cache the value the first time it's gotten.
  	@cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
  	session[:guest_user_id] = nil
  	guest_user if with_retry
  end

  def is_guest_user?
  	current_user && (session[:guest_user_id] && session[:guest_user_id] == current_user.id)
  end

  private
  
  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
  	puts "-----------------> debug login"
  	# For example:
  	# guest_comments = guest_user.comments.all
  	# guest_comments.each do |comment|
  	  # comment.user_id = current_user.id
  	  # comment.save!
  	# end
  end

  def create_guest_user
  	u = User.create(:email => "guest_#{Time.now.to_i}#{rand(100)}@email.com")
  	u.save!(:validate => false)
  	session[:guest_user_id] = u.id
  	u
  end

end
