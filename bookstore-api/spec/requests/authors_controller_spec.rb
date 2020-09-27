require 'rails_helper'

RSpec.describe AuthorsController, type: :request do
  let(:id)              { 1 }
  let(:no_result)       { { data: [] }.to_json }
  let(:error_result)    { { error: "Couldn't find Author" }.to_json }
  
  let(:payload_opened_no_name) { { action: "opened", issue: { title: '', body: 'Adeline Virginia Woolf (25 January 1882 – 28 March 1941).' } }.to_json }
  let(:payload_opened)         { { action: "opened", issue: { title: 'Virginia Woolf', body: 'Adeline Virginia Woolf (25 January 1882 – 28 March 1941).' } }.to_json }

  let(:payload_edited_no_name) { { action: "edited", issue: { title: '' }, changes: { title: { from: 'Alain de Botton' } } }.to_json }
  let(:payload_edited)         { { action: "edited", issue: { title: 'Virginia Woolf' }, changes: { title: { from: 'Alain de Botton' } } }.to_json }

  let(:payload_deleted_no_name) { { action: "deleted", issue: { title: '' } }.to_json }
  let(:payload_deleted)         { { action: "deleted", issue: { title: 'Alain de Botton' } }.to_json }

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

  describe 'POST webhook' do
    describe '.opened' do
      it 'returns a 201 and the author' do
        post "/authors/webhook", params: { payload: payload_opened }

        expect(response).to have_http_status(:created)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 422 and error' do
        author = Author.new
        author.valid?

        post "/authors/webhook", params: { payload: payload_opened_no_name }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eql(author.errors.messages.to_json)
      end
    end

    describe '.edited' do
      it 'returns a 200 and the author' do
        Author.create(name: 'Alain de Botton')

        post '/authors/webhook', params: { payload: payload_edited }

        expect(response).to have_http_status(:ok)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 422 and error' do
        Author.create(name: 'Alain de Botton')
        author = Author.new
        author.valid?

        post '/authors/webhook', params: { payload: payload_edited_no_name }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eql(author.errors.messages.to_json)
      end

      it 'returns a 404 and error' do
        post '/authors/webhook', params: { payload: payload_edited_no_name }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eql(error_result)
      end
    end

    describe '.deleted' do
      it 'returns a 204 and no author' do
        Author.create(name: 'Alain de Botton')
        
        post "/authors/webhook", params: { payload: payload_deleted }
        
        expect(response).to have_http_status(:no_content)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 404 and error' do
        post "/authors/webhook", params: { payload: payload_deleted_no_name }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eql(error_result)
      end
    end
  end
end
