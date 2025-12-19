# BlogPost model for articles/blog
class BlogPost < ApplicationRecord
  include Timestampable
  include Slugifiable
  include Publishable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # Associations
  belongs_to :user
  has_one_attached :cover_image
  has_rich_text :content

  # Validations
  validates :title, presence: true
  validates :slug, uniqueness: true

  # Scopes
  scope :sorted, -> { order(published_at: :desc) }
  scope :visible, -> { published.sorted }

  # Callbacks
  before_save :calculate_reading_time

  # Instance methods
  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end

  def reading_time_text
    "#{reading_time || 1} min read"
  end

  private

  def calculate_reading_time
    return unless content.present?

    # Average reading speed: 200 words per minute
    word_count = content.to_plain_text.split.size
    self.reading_time = [(word_count / 200.0).ceil, 1].max
  end
end
