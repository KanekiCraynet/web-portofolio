# Messages controller for contact form
class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      # Queue notification email
      SendContactNotificationJob.perform_later(@message.id)
      redirect_to root_path, notice: "Thank you for your message! I'll get back to you soon."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :body)
  end
end
