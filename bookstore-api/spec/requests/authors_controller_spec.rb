require 'rails_helper'

RSpec.describe AuthorsController, type: :request do
  let(:id)            { 1 }
  let(:no_result)     { { data: [] }.to_json }
  let(:error_result)  { { error: "Couldn't find Author with 'id'=#{id}" }.to_json }

  describe 'GET index' do
    it 'returns a 200 and no author' do
      get '/authors'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql(no_result)
    end

    it 'returns a 200 and author list' do
      Author.create(name: 'Alain de Botton')

      get '/authors'

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end
  end

  describe 'GET show' do
    it 'returns a 200 and the author' do
      Author.create(name: 'Alain de Botton')

      get "/authors/#{id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      get "/authors/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'POST create' do
    it 'returns a 201 and the author' do
      post '/authors', params: { author: { name: 'Virginia Woolf' } }

      expect(response).to have_http_status(:created)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 422 and error' do
      author = Author.new
      author.valid?

      post '/authors', params: { author: { name: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eql(author.errors.messages.to_json)
    end
  end

  describe 'PATCH/PUT update' do
    it 'returns a 200 and the author' do
      Author.create(name: 'Alain de Botton')

      put "/authors/#{id}", params: { author: { name: 'Simone de Beauvoir' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      put "/authors/#{id}", params: {}

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'DELETE destroy' do
    it 'returns a 204 and no author' do
      Author.create(name: 'Alain de Botton')

      delete "/authors/#{id}"

      expect(response).to have_http_status(:no_content)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      delete "/authors/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end
end
