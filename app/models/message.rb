# Message model for contact form submissions
class Message < ApplicationRecord
  include Timestampable

  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subject, presence: true
  validates :body, presence: true, length: { minimum: 10, maximum: 5000 }

  # Scopes
  scope :unread, -> { where(read: false) }
  scope :read_messages, -> { where(read: true) }

  # Instance methods
  def mark_as_read!
    update!(read: true)
  end

  def unread?
    !read?
  end
end
