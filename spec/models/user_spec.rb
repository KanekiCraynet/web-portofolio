require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:skills).dependent(:destroy) }
    it { should have_many(:experiences).dependent(:destroy) }
    it { should have_many(:blog_posts).dependent(:destroy) }
    it { should have_one_attached(:avatar_image) }
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should have_secure_password }
  end

  describe 'roles' do
    it 'defines user role enum' do
      expect(User.roles).to include('user', 'editor', 'admin')
    end
  end

  describe '#admin?' do
    it 'returns true for admin users' do
      user = build(:user, :admin)
      expect(user.admin?).to be true
    end

    it 'returns false for non-admin users' do
      user = build(:user)
      expect(user.admin?).to be false
    end
  end

  describe '#editor?' do
    it 'returns true for editor users' do
      user = build(:user, :editor)
      expect(user.editor?).to be true
    end

    it 'returns true for admin users' do
      user = build(:user, :admin)
      expect(user.editor?).to be true
    end

    it 'returns false for regular users' do
      user = build(:user)
      expect(user.editor?).to be false
    end
  end

  describe 'email normalization' do
    it 'downcases email before save' do
      user = create(:user, email: 'TEST@EXAMPLE.COM')
      expect(user.email).to eq('test@example.com')
    end
  end
end
