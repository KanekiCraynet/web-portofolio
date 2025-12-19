# Job for processing uploaded images (resizing, optimization)
class ImageProcessingJob < ApplicationJob
  queue_as :default

  def perform(record_id, attachment_name)
    # Find the record dynamically based on class and id
    record = find_record(record_id)
    return unless record

    attachment = record.public_send(attachment_name)
    return unless attachment.attached?

    # Generate common variants for responsive images
    generate_variants(attachment)

    Rails.logger.info "ImageProcessingJob: Processed #{attachment_name} for #{record.class.name} ##{record_id}"
  rescue StandardError => e
    Rails.logger.error "ImageProcessingJob failed: #{e.message}"
    raise e # Re-raise to trigger retry
  end

  private

  def find_record(record_id)
    # Try to find in projects first, then blog_posts
    Project.find_by(id: record_id) || BlogPost.find_by(id: record_id)
  end

  def generate_variants(attachment)
    # Generate thumbnail
    attachment.variant(resize_to_limit: [300, 300]).processed

    # Generate medium size
    attachment.variant(resize_to_limit: [600, 600]).processed

    # Generate large size for hero images
    attachment.variant(resize_to_limit: [1200, 800]).processed
  end
end
