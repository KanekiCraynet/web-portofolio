require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_inclusion_of(:category).in_array(Skill::CATEGORIES) }
    it { should validate_inclusion_of(:proficiency).in_range(1..5) }
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:backend_skill) { create(:skill, user: user, category: 'Backend', proficiency: 5) }
    let!(:frontend_skill) { create(:skill, user: user, category: 'Frontend', proficiency: 3) }

    describe '.by_category' do
      it 'filters by category' do
        expect(Skill.by_category('Backend')).to include(backend_skill)
        expect(Skill.by_category('Backend')).not_to include(frontend_skill)
      end
    end

    describe '.ordered' do
      it 'orders by proficiency desc then name asc' do
        expect(Skill.ordered.first).to eq(backend_skill)
      end
    end
  end

  describe '#proficiency_label' do
    let(:skill) { build(:skill) }

    it 'returns correct label for each level' do
      skill.proficiency = 1
      expect(skill.proficiency_label).to eq('Beginner')

      skill.proficiency = 3
      expect(skill.proficiency_label).to eq('Advanced')

      skill.proficiency = 5
      expect(skill.proficiency_label).to eq('Master')
    end
  end

  describe '#proficiency_percentage' do
    let(:skill) { build(:skill, proficiency: 4) }

    it 'converts proficiency to percentage' do
      expect(skill.proficiency_percentage).to eq(80)
    end
  end
end
