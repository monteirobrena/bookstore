require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:id)            { 1 }
  let(:price)         { [30.0, 50.0, 100.0].sample }
  let(:no_result)     { { data: [], meta: { total: 0 } }.to_json }
  let(:author)        { Author.create(name: 'Simone de Beauvoir') }
  let(:publisher)     { PublishingHouse.create(name: 'Hogarth Press') }
  let(:error_result)  { { error: "Couldn't find Book with 'id'=#{id}" }.to_json }

  describe 'GET index' do
    it 'returns a 200 and no book' do
      get '/books'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql(no_result)
    end

    it 'returns a 200 and book list' do
      Book.create(title: 'Alain de Botton', price: price, author: author, publisher: publisher)

      get '/books'

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end
  end

  describe 'GET show' do
    it 'returns a 200 and the book' do
      Book.create(title: 'Alain de Botton', price: price, author: author, publisher: publisher)

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

  describe 'POST create' do
    it 'returns a 201 and the book' do
      post '/books', params: { book: { title: 'Virginia Woolf', price: price, author_id: author.id, publisher_id: publisher.id, publisher_type: publisher.class.name } }

      expect(response).to have_http_status(:created)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 422 and error' do
      book = Book.new
      book.valid?

      post '/books', params: { book: { title: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eql(book.errors.messages.to_json)
    end
  end

  describe 'PATCH/PUT update' do
    it 'returns a 200 and the book' do
      Book.create(title: 'Alain de Botton', price: price, author: author, publisher: publisher)

      put "/books/#{id}", params: { book: { title: 'Simone de Beauvoir' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 422 and error' do
      Book.create(title: 'Alain de Botton', price: price, author: author, publisher: publisher)
      book = Book.new
      book.valid?

      put "/books/#{id}", params: { book: { title: '', price: '', author_id: '', publisher_id: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eql(book.errors.messages.to_json)
    end

    it 'returns a 404 and error' do
      put "/books/#{id}", params: {}

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'DELETE destroy' do
    it 'returns a 204 and no book' do
      Book.create(title: 'Alain de Botton', price: price, author: author, publisher: publisher)

      delete "/books/#{id}"

      expect(response).to have_http_status(:no_content)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      delete "/books/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end
end
