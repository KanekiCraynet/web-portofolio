# Pages controller for static pages
class PagesController < ApplicationController
  def about
    @user = User.admin.first
    @skills_by_category = Skill.ordered.group_by(&:category)
    @experiences = Experience.chronological
  end

  def contact
    @message = Message.new
  end
end
