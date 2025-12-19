# Blog post card component
class BlogPostCardComponent < ViewComponent::Base
  def initialize(post:)
    @post = post
  end

  def reading_time
    "#{@post.reading_time} min read"
  end

  def published_date
    @post.published_at&.strftime("%B %d, %Y") || "Draft"
  end

  def excerpt
    @post.excerpt.presence || @post.content.truncate(150)
  end

  def tags
    @post.tags_array rescue []
  end
end
