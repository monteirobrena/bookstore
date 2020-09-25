require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:author) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:publisher) }

    describe 'polymorphic' do
      it { is_expected.to have_db_column(:publisher_id).of_type(:integer) }
      it { is_expected.to have_db_column(:publisher_type).of_type(:string) }
    end
  end
end
