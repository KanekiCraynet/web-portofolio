# Experience card component for timeline display
class ExperienceCardComponent < ViewComponent::Base
  def initialize(experience:, index: 0)
    @experience = experience
    @index = index
  end

  def duration_text
    start_text = @experience.start_date.strftime("%b %Y")
    end_text = @experience.end_date ? @experience.end_date.strftime("%b %Y") : "Present"
    "#{start_text} - #{end_text}"
  end

  def duration_months
    @experience.duration_in_months
  end

  def is_current?
    @experience.end_date.nil?
  end

  def timeline_position
    @index.even? ? "left" : "right"
  end
end
