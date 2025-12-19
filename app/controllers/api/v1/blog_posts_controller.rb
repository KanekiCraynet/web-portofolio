# API blog posts controller
module Api
  module V1
    class BlogPostsController < BaseController
      def index
        pagy, posts = pagy(BlogPost.visible, limit: params[:per_page] || 10)

        render_json(
          posts.map { |p| post_summary_json(p) },
          meta: pagy_metadata(pagy)
        )
      end

      def show
        post = BlogPost.friendly.find(params[:id])

        if post.published?
          render_json(post_json(post))
        else
          render_error("Post not found", status: :not_found)
        end
      rescue ActiveRecord::RecordNotFound
        render_error("Post not found", status: :not_found)
      end

      private

      def post_summary_json(post)
        {
          id: post.id,
          title: post.title,
          slug: post.slug,
          excerpt: post.excerpt,
          published_at: post.published_at,
          reading_time: post.reading_time_text
        }
      end

      def post_json(post)
        {
          id: post.id,
          title: post.title,
          slug: post.slug,
          content: post.content.to_s,
          excerpt: post.excerpt,
          published_at: post.published_at,
          reading_time: post.reading_time_text,
          created_at: post.created_at,
          updated_at: post.updated_at
        }
      end
    end
  end
end
