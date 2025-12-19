# Concern for publishable content (projects, blog posts)
module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(published: true) }
    scope :draft, -> { where(published: false) }
    scope :featured, -> { where(featured: true) }
  end

  def publish!
    update!(published: true, published_at: Time.current)
  end

  def unpublish!
    update!(published: false)
  end

  def published?
    published == true
  end

  def draft?
    !published?
  end
end
