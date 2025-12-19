# Public projects controller
class ProjectsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @projects = pagy(Project.published.recent, limit: 12)
  end

  def show
    @project = Project.friendly.find(params[:id])

    # Only show published projects to non-admin users
    unless @project.published? || current_user&.admin?
      redirect_to projects_path, alert: "Project not found"
    end
  end
end
