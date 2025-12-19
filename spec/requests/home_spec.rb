require 'rails_helper'

RSpec.describe 'Home Page', type: :request do
  let(:user) { create(:user, :admin) }

  describe 'GET /' do
    before do
      create_list(:project, 3, :featured, user: user)
      create_list(:skill, 5, user: user)
      create_list(:experience, 2, user: user)
      create_list(:blog_post, 2, :published, user: user)
    end

    it 'returns success' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the home page content' do
      get root_path
      expect(response.body).to include('Featured Projects')
    end
  end

  describe 'GET / without any content' do
    before do
      # Create admin user so page can load
      create(:user, :admin)
    end

    it 'returns success even without content' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
