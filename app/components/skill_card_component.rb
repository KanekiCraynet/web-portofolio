# Skill card component for displaying skills
class SkillCardComponent < ViewComponent::Base
  def initialize(skill:)
    @skill = skill
  end

  def proficiency_percentage
    (@skill.proficiency || 0) * 20
  end

  def proficiency_color
    case @skill.proficiency
    when 5 then "bg-green-500"
    when 4 then "bg-blue-500"
    when 3 then "bg-yellow-500"
    when 2 then "bg-orange-500"
    else "bg-gray-500"
    end
  end

  def proficiency_label
    case @skill.proficiency
    when 5 then "Expert"
    when 4 then "Advanced"
    when 3 then "Intermediate"
    when 2 then "Beginner"
    else "Learning"
    end
  end
end
