class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Pundit authorization
  include Pundit::Authorization

  # Pagy pagination
  include Pagy::Backend

  # Make current_user available in views
  helper_method :current_user, :logged_in?

  # Pundit error handling
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this page"
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action"
    redirect_to(request.referrer || root_path)
  end

  def set_meta_tags_for(object, options = {})
    defaults = {
      site: "Portfolio",
      reverse: true,
      separator: "|"
    }
    set_meta_tags defaults.merge(options)
  end
end
