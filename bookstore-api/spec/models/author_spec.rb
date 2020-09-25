require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:books) }
    it { should have_many(:published) }
  end

  describe '.discount' do
    it { expect(subject.discount).to be_eql(10) }
  end
end
