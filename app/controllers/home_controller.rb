# Home controller for landing page
class HomeController < ApplicationController
  def index
    @featured_projects = Project.published.featured.recent.includes(:featured_image_attachment).limit(6)
    @skills_by_category = Skill.ordered.group_by(&:category)
    @experiences = Experience.chronological.limit(5)
    @recent_posts = BlogPost.visible.limit(3)
    @user = User.admin.first
  end
end
