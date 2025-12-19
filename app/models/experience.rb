# Experience model for work/education timeline
class Experience < ApplicationRecord
  include Timestampable

  # Associations
  belongs_to :user

  # Validations
  validates :company, presence: true
  validates :role, presence: true
  validates :start_date, presence: true
  validate :end_date_after_start_date

  # Scopes
  scope :chronological, -> { order(start_date: :desc) }
  scope :current_positions, -> { where(current: true).or(where(end_date: nil)) }

  # Instance methods
  def duration_in_months
    end_at = end_date || Date.current
    ((end_at.year - start_date.year) * 12 + end_at.month - start_date.month).abs
  end

  def duration_formatted
    months = duration_in_months
    years = months / 12
    remaining_months = months % 12

    parts = []
    parts << "#{years} year#{'s' if years > 1}" if years > 0
    parts << "#{remaining_months} month#{'s' if remaining_months > 1}" if remaining_months > 0
    parts.join(", ")
  end

  def current?
    current == true || end_date.nil?
  end

  private

  def end_date_after_start_date
    return unless end_date.present? && start_date.present?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
