# Concern for common timestamp-related scopes
module Timestampable
  extend ActiveSupport::Concern

  included do
    scope :recent, -> { order(created_at: :desc) }
    scope :older, -> { order(created_at: :asc) }
    scope :updated_recently, -> { order(updated_at: :desc) }
  end

  class_methods do
    def created_between(start_date, end_date)
      where(created_at: start_date..end_date)
    end
  end
end
