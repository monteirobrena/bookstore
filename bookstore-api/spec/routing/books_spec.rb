require 'rails_helper'

RSpec.describe 'routes to the BooksController', type: :routing do
  let (:id) { 1 }

  describe 'GET index' do
    it { should route(:get, '/books').to(controller: :books, action: :index) }
  end

  describe 'GET show' do
    it { should route(:get, "/books/#{id}").to(controller: :books, action: :show, id: id) }
  end

  describe 'POST create' do
    it { should route(:post, '/books').to(controller: :books, action: :create) }
  end

  describe 'PATCH/PUT show' do
    it { should route(:put, "/books/#{id}").to(controller: :books, action: :update, id: id) }
  end

  describe 'DELETE destroy' do
    it { should route(:delete, "/books/#{id}").to(controller: :books, action: :destroy, id: id) }
  end
end
