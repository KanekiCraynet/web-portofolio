# Admin messages controller
module Admin
  class MessagesController < BaseController
    include Pagy::Backend

    before_action :set_message, only: [:show, :destroy, :mark_as_read]

    def index
      @pagy, @messages = pagy(Message.recent, limit: 20)
    end

    def show
      @message.mark_as_read! unless @message.read?
    end

    def destroy
      @message.destroy
      redirect_to admin_messages_path, notice: "Message deleted successfully"
    end

    def mark_as_read
      @message.mark_as_read!
      redirect_to admin_messages_path, notice: "Message marked as read"
    end

    private

    def set_message
      @message = Message.find(params[:id])
    end
  end
end
