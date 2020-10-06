require 'rails_helper'

RSpec.describe 'routes to the AuthorsController', type: :routing do
  let (:id) { 1 }

  describe 'GET index' do
    it { should route(:get, '/authors').to(controller: :authors, action: :index) }
  end

  describe 'GET show' do
    it { should route(:get, "/authors/#{id}").to(controller: :authors, action: :show, id: id) }
  end

  describe 'POST webhook' do
    it { should route(:post, '/authors/webhook').to(controller: :authors, action: :webhook) }
  end
end
