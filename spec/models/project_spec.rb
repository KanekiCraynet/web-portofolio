require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:featured_image) }
    it { should have_many_attached(:gallery_images) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:published_project) { create(:project, :published, user: user) }
    let!(:draft_project) { create(:project, user: user) }
    let!(:featured_project) { create(:project, :featured, user: user) }

    describe '.published' do
      it 'returns only published projects' do
        expect(Project.published).to include(published_project, featured_project)
        expect(Project.published).not_to include(draft_project)
      end
    end

    describe '.featured' do
      it 'returns only featured projects' do
        expect(Project.featured).to include(featured_project)
        expect(Project.featured).not_to include(published_project, draft_project)
      end
    end

    describe '.recent' do
      it 'orders by created_at desc' do
        expect(Project.recent.first).to eq(featured_project)
      end
    end
  end

  describe '#technologies_array' do
    let(:project) { build(:project, technologies: 'Ruby, Rails, PostgreSQL') }

    it 'returns technologies as array' do
      expect(project.technologies_array).to eq(['Ruby', 'Rails', 'PostgreSQL'])
    end

    it 'handles nil technologies' do
      project.technologies = nil
      expect(project.technologies_array).to eq([])
    end
  end

  describe '#publish!' do
    let(:project) { create(:project) }

    it 'sets published to true' do
      project.publish!
      expect(project.published?).to be true
    end
  end

  describe '#unpublish!' do
    let(:project) { create(:project, :published) }

    it 'sets published to false' do
      project.unpublish!
      expect(project.published?).to be false
    end
  end

  describe 'FriendlyId' do
    let(:user) { create(:user) }
    let(:project) { create(:project, title: 'My Awesome Project', user: user) }

    it 'generates slug from title' do
      expect(project.slug).to eq('my-awesome-project')
    end

    it 'can be found by slug' do
      expect(Project.friendly.find(project.slug)).to eq(project)
    end
  end
end
