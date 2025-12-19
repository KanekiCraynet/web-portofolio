# Skill model for skills showcase
class Skill < ApplicationRecord
  include Timestampable

  # Associations
  belongs_to :user

  # Constants
  CATEGORIES = %w[Frontend Backend DevOps Database Tools Mobile Other].freeze

  # Validations
  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :proficiency, inclusion: { in: 1..5 }, allow_nil: true

  # Scopes
  scope :by_category, ->(cat) { where(category: cat) }
  scope :ordered, -> { order(proficiency: :desc, name: :asc) }

  # Instance methods
  def proficiency_label
    case proficiency
    when 1 then "Beginner"
    when 2 then "Intermediate"
    when 3 then "Advanced"
    when 4 then "Expert"
    when 5 then "Master"
    else "Unknown"
    end
  end

  def proficiency_percentage
    (proficiency.to_i * 20)
  end
end
