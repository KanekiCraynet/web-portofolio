# Footer component for site-wide footer
class FooterComponent < ViewComponent::Base
  def initialize(user: nil)
    @user = user
  end

  def social_links
    return [] unless @user

    links = []
    links << { name: "GitHub", url: @user.github_url, icon: "github" } if @user.github_url.present?
    links << { name: "LinkedIn", url: @user.linkedin_url, icon: "linkedin" } if @user.linkedin_url.present?
    links << { name: "Twitter", url: @user.twitter_url, icon: "twitter" } if @user.twitter_url.present?
    links
  end

  def current_year
    Date.current.year
  end
end
