require 'rails_helper'

RSpec.describe 'API V1 Projects', type: :request do
  let(:user) { create(:user, :admin) }

  describe 'GET /api/v1/projects' do
    let!(:published_projects) { create_list(:project, 3, :published, user: user) }
    let!(:draft_project) { create(:project, user: user, published: false) }

    it 'returns a list of published projects' do
      get '/api/v1/projects'

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(3)
    end

    it 'does not include draft projects' do
      get '/api/v1/projects'

      json = JSON.parse(response.body)
      project_ids = json['data'].map { |p| p['id'] }
      expect(project_ids).not_to include(draft_project.id)
    end

    it 'returns JSON format' do
      get '/api/v1/projects'
      expect(response.content_type).to include('application/json')
    end

    it 'includes pagination metadata' do
      get '/api/v1/projects'

      json = JSON.parse(response.body)
      expect(json['meta']).to include('current_page', 'total_pages', 'total_count')
    end
  end

  describe 'GET /api/v1/projects/:id' do
    let(:project) { create(:project, :published, user: user) }

    it 'returns the project details' do
      get "/api/v1/projects/#{project.slug}"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data']['title']).to eq(project.title)
    end

    context 'when project is not found' do
      it 'returns not found status' do
        get '/api/v1/projects/non-existent-slug'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when project is not published' do
      let(:draft_project) { create(:project, user: user, published: false) }

      it 'returns not found status' do
        get "/api/v1/projects/#{draft_project.slug}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
