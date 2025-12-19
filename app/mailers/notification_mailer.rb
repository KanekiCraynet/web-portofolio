# Mailer for sending notifications
class NotificationMailer < ApplicationMailer
  default from: -> { ENV.fetch("MAILER_FROM", "noreply@portfolio.com") }

  # Email sent when someone submits the contact form
  def contact_message(message)
    @message = message
    @admin_email = User.admin.first&.email || ENV.fetch("ADMIN_EMAIL", "admin@portfolio.com")

    mail(
      to: @admin_email,
      subject: "[Portfolio Contact] #{@message.subject}"
    )
  end
end
