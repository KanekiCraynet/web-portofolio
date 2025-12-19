# Public blog posts controller
class BlogPostsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @blog_posts = pagy(BlogPost.visible, limit: 10)
  end

  def show
    @blog_post = BlogPost.friendly.find(params[:id])

    unless @blog_post.published? || current_user&.admin?
      redirect_to blog_posts_path, alert: "Post not found"
    end
  end
end
