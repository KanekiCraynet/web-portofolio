require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:editor) { create(:user, :editor) }
  let(:project) { create(:project, user: user) }
  let(:other_project) { create(:project) }

  describe '#index?' do
    it 'allows everyone' do
      expect(described_class.new(nil, Project).index?).to be true
      expect(described_class.new(user, Project).index?).to be true
    end
  end

  describe '#show?' do
    context 'with published project' do
      let(:published_project) { create(:project, :published) }

      it 'allows everyone' do
        expect(described_class.new(nil, published_project).show?).to be true
        expect(described_class.new(user, published_project).show?).to be true
      end
    end

    context 'with draft project' do
      it 'allows owner' do
        expect(described_class.new(user, project).show?).to be true
      end

      it 'allows admin' do
        expect(described_class.new(admin, project).show?).to be true
      end

      it 'denies other users' do
        expect(described_class.new(editor, other_project).show?).to be false
      end
    end
  end

  describe '#create?' do
    it 'allows admin' do
      expect(described_class.new(admin, Project.new).create?).to be true
    end

    it 'allows editor' do
      expect(described_class.new(editor, Project.new).create?).to be true
    end

    it 'denies regular user' do
      expect(described_class.new(user, Project.new).create?).to be false
    end
  end

  describe '#update?' do
    it 'allows admin' do
      expect(described_class.new(admin, project).update?).to be true
    end

    it 'allows owner who is editor' do
      project.user = editor
      expect(described_class.new(editor, project).update?).to be true
    end

    it 'denies non-owner editor' do
      expect(described_class.new(editor, other_project).update?).to be false
    end
  end

  describe '#destroy?' do
    it 'allows admin' do
      expect(described_class.new(admin, project).destroy?).to be true
    end

    it 'denies non-owner editor' do
      expect(described_class.new(editor, other_project).destroy?).to be false
    end
  end
end
