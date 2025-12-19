require 'rails_helper'

RSpec.describe 'API V1 Skills', type: :request do
  let(:user) { create(:user, :admin) }

  describe 'GET /api/v1/skills' do
    before do
      create_list(:skill, 5, user: user)
    end

    it 'returns a list of skills' do
      get '/api/v1/skills'

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(5)
    end

    it 'returns JSON format' do
      get '/api/v1/skills'
      expect(response.content_type).to include('application/json')
    end

    it 'returns skills with expected attributes' do
      get '/api/v1/skills'

      json = JSON.parse(response.body)
      expect(json['data'].first).to include('name', 'category', 'proficiency')
    end
  end
end
