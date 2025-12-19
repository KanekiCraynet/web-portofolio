# API experiences controller
module Api
  module V1
    class ExperiencesController < BaseController
      def index
        experiences = Experience.chronological

        render_json(experiences.map { |e| experience_json(e) })
      end

      private

      def experience_json(experience)
        {
          id: experience.id,
          company: experience.company,
          role: experience.role,
          description: experience.description,
          location: experience.location,
          start_date: experience.start_date,
          end_date: experience.end_date,
          current: experience.current?,
          duration: experience.duration_formatted
        }
      end
    end
  end
end
