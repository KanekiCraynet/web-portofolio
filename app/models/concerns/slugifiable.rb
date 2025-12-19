# Concern for SEO-friendly URL slugs using FriendlyId
module Slugifiable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId

    # Subclasses should call: friendly_id :title, use: [:slugged, :history]
    # in their model definition to set the slug source column
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
