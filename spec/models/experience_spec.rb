require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:start_date) }

    context 'end_date validation' do
      let(:user) { create(:user) }
      let(:experience) { build(:experience, user: user, start_date: Date.new(2023, 1, 1)) }

      it 'is valid when end_date is after start_date' do
        experience.end_date = Date.new(2024, 1, 1)
        expect(experience).to be_valid
      end

      it 'is invalid when end_date is before start_date' do
        experience.end_date = Date.new(2022, 1, 1)
        expect(experience).not_to be_valid
        expect(experience.errors[:end_date]).to include('must be after start date')
      end

      it 'is valid when end_date is nil (current position)' do
        experience.end_date = nil
        expect(experience).to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:older_experience) { create(:experience, user: user, start_date: Date.new(2020, 1, 1)) }
    let!(:newer_experience) { create(:experience, user: user, start_date: Date.new(2023, 1, 1)) }

    describe '.chronological' do
      it 'orders by start_date desc' do
        expect(Experience.chronological.first).to eq(newer_experience)
      end
    end

    describe '.current_positions' do
      let!(:current_position) { create(:experience, :current, user: user) }

      it 'returns current positions' do
        expect(Experience.current_positions).to include(current_position)
      end
    end
  end

  describe '#duration_in_months' do
    let(:experience) { build(:experience, start_date: Date.new(2023, 1, 1), end_date: Date.new(2023, 7, 1)) }

    it 'calculates duration in months' do
      expect(experience.duration_in_months).to eq(6)
    end

    it 'calculates duration to current date when end_date is nil' do
      experience.end_date = nil
      expect(experience.duration_in_months).to be > 0
    end
  end

  describe '#duration_formatted' do
    let(:experience) { build(:experience, start_date: Date.new(2022, 1, 1), end_date: Date.new(2024, 3, 1)) }

    it 'formats duration as years and months' do
      expect(experience.duration_formatted).to include('year')
      expect(experience.duration_formatted).to include('month')
    end
  end

  describe '#current?' do
    it 'returns true when current is true' do
      experience = build(:experience, current: true, end_date: nil)
      expect(experience.current?).to be true
    end

    it 'returns true when end_date is nil' do
      experience = build(:experience, current: false, end_date: nil)
      expect(experience.current?).to be true
    end

    it 'returns false when end_date is set' do
      experience = build(:experience, current: false, end_date: Date.yesterday)
      expect(experience.current?).to be false
    end
  end
end
