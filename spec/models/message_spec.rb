require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }

    context 'email format' do
      it 'accepts valid email addresses' do
        message = build(:message, email: 'test@example.com')
        expect(message).to be_valid
      end

      it 'rejects invalid email addresses' do
        message = build(:message, email: 'invalid-email')
        expect(message).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:read_message) { create(:message, read: true) }
    let!(:unread_message) { create(:message, read: false) }

    describe '.unread' do
      it 'returns only unread messages' do
        expect(Message.unread).to include(unread_message)
        expect(Message.unread).not_to include(read_message)
      end
    end
  end

  describe '#mark_as_read!' do
    let(:message) { create(:message, read: false) }

    it 'marks the message as read' do
      message.mark_as_read!
      expect(message.reload.read).to be true
    end
  end
end
