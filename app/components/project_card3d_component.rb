# 3D Project card component with flip effect for displaying projects
class ProjectCard3dComponent < ViewComponent::Base
  def initialize(project:)
    @project = project
  end

  def featured_image_path
    if @project.featured_image.attached?
      @project.featured_image.variant(resize_to_limit: [600, 400])
    else
      "placeholder-project.jpg"
    end
  end

  def has_featured_image?
    @project.featured_image.attached?
  end

  def technologies
    @project.technologies_array.first(4)
  end

  def has_more_technologies?
    @project.technologies_array.length > 4
  end

  def remaining_technologies_count
    @project.technologies_array.length - 4
  end

  def truncated_description
    helpers.truncate(@project.description, length: 80)
  end

  def project_path
    helpers.project_path(@project)
  end
end
