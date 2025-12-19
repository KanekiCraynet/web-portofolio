# Project model for portfolio projects
class Project < ApplicationRecord
  include Timestampable
  include Slugifiable
  include Publishable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # Associations
  belongs_to :user
  has_one_attached :featured_image
  has_many_attached :gallery_images

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :slug, uniqueness: true

  # Scopes
  scope :by_technology, ->(tech) { where("technologies ILIKE ?", "%#{tech}%") }
  scope :visible, -> { published.order(created_at: :desc) }

  # Instance methods
  def featured_image_url
    featured_image.attached? ? featured_image : nil
  end

  def technologies_array
    technologies&.split(",")&.map(&:strip) || []
  end

  def technologies_array=(arr)
    self.technologies = arr.join(", ")
  end

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
