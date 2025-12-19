# Admin settings controller for profile and site configuration
module Admin
  class SettingsController < BaseController
    def index
      @user = current_user
    end

    def update
      @user = current_user

      if @user.update(user_params)
        redirect_to admin_settings_path, notice: "Settings updated successfully"
      else
        render :index, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :name, :email, :bio, :tagline, :location,
        :github_url, :linkedin_url, :twitter_url, :website_url,
        :avatar_image
      )
    end
  end
end
