require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { create(:user, :admin) }

  describe 'GET /projects' do
    let!(:published_projects) { create_list(:project, 3, :published, user: user) }
    let!(:draft_project) { create(:project, user: user, published: false) }

    it 'returns success' do
      get projects_path
      expect(response).to have_http_status(:success)
    end

    it 'displays published projects' do
      get projects_path
      published_projects.each do |project|
        expect(response.body).to include(project.title)
      end
    end

    it 'does not display draft projects' do
      get projects_path
      expect(response.body).not_to include(draft_project.title)
    end
  end

  describe 'GET /projects/:id' do
    let(:project) { create(:project, :published, user: user) }

    it 'returns success' do
      get project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'displays project details' do
      get project_path(project)
      expect(response.body).to include(project.title)
    end
  end
end
