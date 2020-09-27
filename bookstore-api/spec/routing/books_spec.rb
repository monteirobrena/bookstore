require 'rails_helper'

RSpec.describe 'routes to the BooksController', type: :routing do
  let (:id) { 1 }

  describe 'GET index' do
    it { should route(:get, '/books').to(controller: :books, action: :index) }
  end

  describe 'GET show' do
    it { should route(:get, "/books/#{id}").to(controller: :books, action: :show, id: id) }
  end

  describe 'POST webhook' do
    it { should route(:post, '/books/webhook').to(controller: :books, action: :webhook) }
  end
end
