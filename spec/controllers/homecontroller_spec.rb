require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET' do
    it 'returns a successful response for new' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new template for new' do
      get :new
      expect(response).to render_template('new')
    end

    it 'returns a successful response for create' do
      user = User.create(username: 'Test')
      expect(response).to be_successful
    end

    it 'renders the new template for create' do
      user = User.create(username: 'test')
      expect(response).to_not render_template('create')
    end
  end
end
