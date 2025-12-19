# Sitemap controller for SEO
class SitemapsController < ApplicationController
  def index
    @projects = Project.published.recent
    @blog_posts = BlogPost.published.recent

    respond_to do |format|
      format.xml
    end
  end
end
