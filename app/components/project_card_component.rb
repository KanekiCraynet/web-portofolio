# Project card component for displaying projects in grid
class ProjectCardComponent < ViewComponent::Base
  def initialize(project:)
    @project = project
  end

  def featured_image_path
    if @project.featured_image.attached?
      @project.featured_image.variant(resize_to_limit: [400, 300])
    else
      "placeholder-project.jpg"
    end
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
end
