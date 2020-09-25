require 'rails_helper'

RSpec.describe 'routes to the PublishingHousesController', type: :routing do
  let (:id) { 1 }

  describe 'GET index' do
    it { should route(:get, '/publishing-houses').to(controller: :publishing_houses, action: :index) }
  end

  describe 'GET show' do
    it { should route(:get, "/publishing-houses/#{id}").to(controller: :publishing_houses, action: :show, id: id) }
  end

  describe 'POST create' do
    it { should route(:post, '/publishing-houses').to(controller: :publishing_houses, action: :create) }
  end

  describe 'PATCH/PUT show' do
    it { should route(:put, "/publishing-houses/#{id}").to(controller: :publishing_houses, action: :update, id: id) }
  end

  describe 'DELETE destroy' do
    it { should route(:delete, "/publishing-houses/#{id}").to(controller: :publishing_houses, action: :destroy, id: id) }
  end
end
