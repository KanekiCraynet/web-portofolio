# API base controller
module Api
  module V1
    class BaseController < ActionController::API
      include Pagy::Backend

      # Override pagy to work with API responses
      def pagy_metadata(pagy)
        {
          current_page: pagy.page,
          total_pages: pagy.pages,
          total_count: pagy.count,
          per_page: pagy.limit
        }
      end

      private

      def render_json(data, status: :ok, meta: nil)
        response = { data: data }
        response[:meta] = meta if meta
        render json: response, status: status
      end

      def render_error(message, status: :unprocessable_entity)
        render json: { error: message }, status: status
      end
    end
  end
end
