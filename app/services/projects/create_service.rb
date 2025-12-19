# Service to create a new project
module Projects
  class CreateService < ApplicationService
    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      project = @user.projects.build(project_attributes)

      if project.save
        # Queue image processing if image attached
        if project.featured_image.attached?
          ImageProcessingJob.perform_later(project.id, "featured_image")
        end

        success(project)
      else
        failure(project.errors.full_messages)
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
