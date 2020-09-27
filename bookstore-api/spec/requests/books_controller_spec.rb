require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:id)            { 1 }
  let(:no_result)     { { data: [], meta: { total: 0 } }.to_json }
  let(:author)        { Author.create(name: 'Alain de Botton') }
  let(:publisher)     { PublishingHouse.create(name: 'Hogarth Press') }

  let(:error_result)         { { error: "Couldn't find Book" }.to_json }
  let(:error_result_author)  { { error: "Couldn't find Author" }.to_json }

  let(:payload_created_no_name) { { action: "created", comment: { body: "" }, issue: { title: author.name } }.to_json }
  let(:payload_created)         { { action: "created", comment: { body: 'The Architecture of Happiness' }, issue: { title: author.name } }.to_json }

  let(:payload_edited_no_name) { { action: "edited", comment: { body: "" }, issue: { title: author.name }, changes: { body: { from: 'The Architecture of Happiness' } } }.to_json }
  let(:payload_edited)         { { action: "edited", comment: { body: 'The Architecture of Happiness' }, issue: { title: author.name }, changes: { title: { from: "The News: A User's Manual" } } }.to_json }

  let(:payload_deleted_no_name)   { { action: "deleted", comment: { body: "" }, issue: { title: author.name } }.to_json }
  let(:payload_deleted_no_author) { { action: "deleted", comment: { body: "The Architecture of Happiness" }, issue: { title: 'Virginia Wolf' } }.to_json }
  let(:payload_deleted)           { { action: "deleted", comment: { body: 'The Architecture of Happiness' }, issue: { title: author.name } }.to_json }

  describe 'GET index' do
    it 'returns a 200 and no book' do
      get '/books'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql(no_result)
    end

    it 'returns a 200 and book list' do
      Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)

      get '/books'

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end
  end

  describe 'GET show' do
    it 'returns a 200 and the book' do
      Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)

      get "/books/#{id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      get "/books/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'POST webhook' do
    describe '.opened' do
      it 'returns a 201 and the book' do
        post "/books/webhook", params: { payload: payload_created }

        expect(response).to have_http_status(:created)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 422 and error' do
        book = Book.new(author: author, publisher: publisher)
        book.valid?

        post "/books/webhook", params: { payload: payload_created_no_name }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eql(book.errors.messages.to_json)
      end
    end

    describe '.edited' do
      it 'returns a 200 and the book' do
        Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)

        post '/books/webhook', params: { payload: payload_edited }

        expect(response).to have_http_status(:ok)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 422 and error' do
        Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)
        book = Book.new(author: author, publisher: publisher)
        book.valid?

        post '/books/webhook', params: { payload: payload_edited_no_name }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eql(book.errors.messages.to_json)
      end

      it 'returns a 404 and error' do
        post '/books/webhook', params: { payload: payload_edited_no_name }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eql(error_result)
      end
    end

    describe '.deleted' do
      it 'returns a 204 and no book' do
        Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)
        
        post "/books/webhook", params: { payload: payload_deleted }
        
        expect(response).to have_http_status(:no_content)
        expect(response.body).to_not eql(no_result)
      end

      it 'returns a 404 and error because not found the book' do
        Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)

        post "/books/webhook", params: { payload: payload_deleted_no_name }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eql(error_result)
      end

      it 'returns a 404 and error because not found author' do
        Book.create(title: 'The Architecture of Happiness', author: author, publisher: publisher)

        post "/books/webhook", params: { payload: payload_deleted_no_author }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eql(error_result_author)
      end
    end
  end
end
