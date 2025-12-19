# API projects controller
module Api
  module V1
    class ProjectsController < BaseController
      def index
        pagy, projects = pagy(Project.published.recent, limit: params[:per_page] || 20)

        render_json(
          projects.as_json(only: [:id, :title, :slug, :description, :technologies, :live_url, :github_url, :created_at]),
          meta: pagy_metadata(pagy)
        )
      end

      def show
        project = Project.friendly.find(params[:id])

        if project.published?
          render_json(project.as_json(
            only: [:id, :title, :slug, :description, :technologies, :live_url, :github_url, :created_at, :updated_at]
          ))
        else
          render_error("Project not found", status: :not_found)
        end
      rescue ActiveRecord::RecordNotFound
        render_error("Project not found", status: :not_found)
      end
    end
  end
end
