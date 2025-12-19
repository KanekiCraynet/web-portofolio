# Admin dashboard controller
module Admin
  class DashboardController < BaseController
    def index
      @projects_count = Project.count
      @published_projects_count = Project.published.count
      @skills_count = Skill.count
      @experiences_count = Experience.count
      @blog_posts_count = BlogPost.count
      @unread_messages_count = Message.unread.count
      @recent_messages = Message.recent.limit(5)
      @recent_projects = Project.recent.limit(5)
    end
  end
end
