# Admin base controller - all admin controllers inherit from this
module Admin
  class BaseController < ApplicationController
    before_action :require_admin!

    layout "admin"

    private

    def require_admin!
      unless current_user&.admin?
        redirect_to login_path, alert: "You must be an admin to access this area"
      end
    end
  end
end
