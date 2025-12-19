require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:cover_image) }
    it { should have_rich_text(:content) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }

    context 'slug uniqueness' do
      let(:user) { create(:user) }
      let!(:existing_post) { create(:blog_post, user: user, title: 'My Post') }

      it 'generates unique slugs' do
        new_post = create(:blog_post, user: user, title: 'My Post')
        expect(new_post.slug).not_to eq(existing_post.slug)
      end
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:published_post) { create(:blog_post, :published, user: user) }
    let!(:draft_post) { create(:blog_post, user: user, published: false) }

    describe '.published' do
      it 'returns only published posts' do
        expect(BlogPost.published).to include(published_post)
        expect(BlogPost.published).not_to include(draft_post)
      end
    end

    describe '.sorted' do
      let!(:older_post) { create(:blog_post, :published, user: user, published_at: 1.week.ago) }
      let!(:newer_post) { create(:blog_post, :published, user: user, published_at: 1.day.ago) }

      it 'orders by published_at desc' do
        sorted = BlogPost.sorted
        expect(sorted.index(newer_post)).to be < sorted.index(older_post)
      end
    end

    describe '.visible' do
      it 'returns published posts sorted by date' do
        expect(BlogPost.visible).to include(published_post)
        expect(BlogPost.visible).not_to include(draft_post)
      end
    end
  end

  describe 'FriendlyId' do
    let(:user) { create(:user) }
    let(:post) { create(:blog_post, title: 'My Amazing Blog Post', user: user) }

    it 'generates slug from title' do
      expect(post.slug).to eq('my-amazing-blog-post')
    end

    it 'can be found by slug' do
      expect(BlogPost.friendly.find(post.slug)).to eq(post)
    end
  end

  describe '#reading_time_text' do
    let(:post) { build(:blog_post, reading_time: 5) }

    it 'returns formatted reading time' do
      expect(post.reading_time_text).to eq('5 min read')
    end

    it 'defaults to 1 min when reading_time is nil' do
      post.reading_time = nil
      expect(post.reading_time_text).to eq('1 min read')
    end
  end

  describe 'reading time calculation' do
    let(:user) { create(:user) }

    it 'calculates reading time based on content length' do
      post = create(:blog_post, user: user)
      post.content = 'word ' * 400  # 400 words = 2 min read
      post.save!
      expect(post.reading_time).to eq(2)
    end
  end
end
