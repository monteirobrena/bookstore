require 'rails_helper'

RSpec.describe 'routes to the AuthorsController', type: :routing do
  let (:id) { 1 }

  describe 'GET index' do
    it { should route(:get, '/authors').to(controller: :authors, action: :index) }
  end

  describe 'GET show' do
    it { should route(:get, "/authors/#{id}").to(controller: :authors, action: :show, id: id) }
  end

  describe 'POST create' do
    it { should route(:post, '/authors').to(controller: :authors, action: :create) }
  end

  describe 'PATCH/PUT show' do
    it { should route(:put, "/authors/#{id}").to(controller: :authors, action: :update, id: id) }
  end

  describe 'DELETE destroy' do
    it { should route(:delete, "/authors/#{id}").to(controller: :authors, action: :destroy, id: id) }
  end
end
