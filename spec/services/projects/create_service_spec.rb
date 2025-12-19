require 'rails_helper'

RSpec.describe Projects::CreateService do
  let(:user) { create(:user, :admin) }
  let(:valid_params) do
    {
      title: 'New Project',
      description: 'A description for the project',
      technologies: 'Ruby, Rails, PostgreSQL',
      github_url: 'https://github.com/user/project',
      live_url: 'https://example.com'
    }
  end

  describe '.call' do
    context 'with valid params' do
      it 'creates a new project' do
        expect {
          Projects::CreateService.call(user: user, params: valid_params)
        }.to change(Project, :count).by(1)
      end

      it 'returns a successful result' do
        result = Projects::CreateService.call(user: user, params: valid_params)
        expect(result).to be_success
        expect(result.data).to be_a(Project)
        expect(result.data.title).to eq('New Project')
      end

      it 'associates the project with the user' do
        result = Projects::CreateService.call(user: user, params: valid_params)
        expect(result.data.user).to eq(user)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { title: '' } }

      it 'does not create a project' do
        expect {
          Projects::CreateService.call(user: user, params: invalid_params)
        }.not_to change(Project, :count)
      end

      it 'returns a failure result' do
        result = Projects::CreateService.call(user: user, params: invalid_params)
        expect(result).to be_failure
        expect(result.errors).not_to be_empty
      end
    end
  end
end
