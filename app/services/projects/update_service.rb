# Service to update an existing project
module Projects
  class UpdateService < ApplicationService
    def initialize(project:, params:)
      @project = project
      @params = params
    end

    def call
      if @project.update(project_attributes)
        # Queue image processing if new image attached
        if @params[:featured_image].present?
          ImageProcessingJob.perform_later(@project.id, "featured_image")
        end

        success(@project)
      else
        failure(@project.errors.full_messages)
      end
    end

    private

    def project_attributes
      @params.slice(
        :title, :description, :technologies,
        :live_url, :github_url, :featured_image,
        :published, :featured
      )
    end
  end
end
