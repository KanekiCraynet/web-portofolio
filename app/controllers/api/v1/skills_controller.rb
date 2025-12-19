# API skills controller
module Api
  module V1
    class SkillsController < BaseController
      def index
        skills = Skill.ordered

        # Group by category if requested
        if params[:grouped] == "true"
          grouped = skills.group_by(&:category).transform_values do |category_skills|
            category_skills.map { |s| skill_json(s) }
          end
          render_json(grouped)
        else
          render_json(skills.map { |s| skill_json(s) })
        end
      end

      private

      def skill_json(skill)
        {
          id: skill.id,
          name: skill.name,
          category: skill.category,
          proficiency: skill.proficiency,
          proficiency_label: skill.proficiency_label
        }
      end
    end
  end
end
