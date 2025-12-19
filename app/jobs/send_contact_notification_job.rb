# Job for sending contact form notification emails
class SendContactNotificationJob < ApplicationJob
  queue_as :mailers

  def perform(message_id)
    message = Message.find_by(id: message_id)
    return unless message

    NotificationMailer.contact_message(message).deliver_now

    Rails.logger.info "SendContactNotificationJob: Sent notification for message ##{message_id}"
  rescue StandardError => e
    Rails.logger.error "SendContactNotificationJob failed: #{e.message}"
    raise e
  end
end
