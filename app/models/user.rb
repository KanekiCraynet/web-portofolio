# User model for authentication and content ownership
class User < ApplicationRecord
  include Timestampable

  has_secure_password

  # Associations
  has_many :projects, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :blog_posts, dependent: :destroy

  # Active Storage for avatar
  has_one_attached :avatar_image

  # Validations
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  # Enums
  enum :role, { user: 0, editor: 1, admin: 2 }, default: :user

  # Callbacks
  before_save :downcase_email

  # Instance methods
  def admin?
    role == "admin"
  end

  def editor?
    role == "editor" || admin?
  end

  def full_name
    name
  end

  def avatar_url
    if avatar_image.attached?
      avatar_image
    else
      avatar.presence || "default-avatar.png"
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
