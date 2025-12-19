require 'rails_helper'

RSpec.describe Projects::UpdateService do
  let(:user) { create(:user, :admin) }
  let(:project) { create(:project, user: user, title: 'Original Title') }
  let(:valid_params) do
    {
      title: 'Updated Title',
      description: 'Updated description'
    }
  end

  describe '.call' do
    context 'with valid params' do
      it 'updates the project' do
        result = Projects::UpdateService.call(project: project, params: valid_params)
        expect(result).to be_success
        expect(result.data.title).to eq('Updated Title')
      end

      it 'persists the changes' do
        Projects::UpdateService.call(project: project, params: valid_params)
        expect(project.reload.title).to eq('Updated Title')
      end

      it 'returns a successful result' do
        result = Projects::UpdateService.call(project: project, params: valid_params)
        expect(result).to be_success
        expect(result.data).to eq(project)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { title: '', description: '' } }

      it 'does not update the project' do
        Projects::UpdateService.call(project: project, params: invalid_params)
        expect(project.reload.title).to eq('Original Title')
      end

      it 'returns a failure result' do
        result = Projects::UpdateService.call(project: project, params: invalid_params)
        expect(result).to be_failure
        expect(result.errors).not_to be_empty
      end
    end
  end
end
