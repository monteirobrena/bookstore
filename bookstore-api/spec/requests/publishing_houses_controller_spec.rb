require 'rails_helper'

RSpec.describe PublishingHousesController, type: :request do
  let(:id)            { 1 }
  let(:no_result)     { { data: [] }.to_json }
  let(:error_result)  { { error: "Couldn't find PublishingHouse with 'id'=#{id}" }.to_json }

  describe 'GET index' do
    it 'returns a 200 and no publishing house' do
      get '/publishing-houses'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql(no_result)
    end

    it 'returns a 200 and publishing house list' do
      PublishingHouse.create(name: 'Hogarth Press')

      get '/publishing-houses'

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end
  end

  describe 'GET show' do
    it 'returns a 200 and the publishing house' do
      PublishingHouse.create(name: 'Hogarth Press')

      get "/publishing-houses/#{id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      get "/publishing-houses/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'POST create' do
    it 'returns a 201 and the publishing house' do
      post '/publishing-houses', params: { publishing_house: { name: 'Penguin Random House' } }

      expect(response).to have_http_status(:created)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 422 and error' do
      publishing_house = PublishingHouse.new
      publishing_house.valid?

      post '/publishing-houses', params: { publishing_house: { name: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eql(publishing_house.errors.messages.to_json)
    end
  end

  describe 'PATCH/PUT update' do
    it 'returns a 200 and the publishing house' do
      PublishingHouse.create(name: 'Hogarth Press')

      put "/publishing-houses/#{id}", params: { publishing_house: { name: 'Penguin Random House' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      put "/publishing-houses/#{id}", params: {}

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end

  describe 'DELETE destroy' do
    it 'returns a 204 and no publishing house' do
      PublishingHouse.create(name: 'Hogarth Press')

      delete "/publishing-houses/#{id}"

      expect(response).to have_http_status(:no_content)
      expect(response.body).to_not eql(no_result)
    end

    it 'returns a 404 and error' do
      delete "/publishing-houses/#{id}"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eql(error_result)
    end
  end
end
