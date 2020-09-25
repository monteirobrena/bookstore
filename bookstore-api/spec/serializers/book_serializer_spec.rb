require 'rails_helper'

RSpec.describe BookSerializer, type: :serializer do
  let(:book)            { Book.new }
  let(:book_serializer) { BookSerializer.new(book) }

  subject { ActiveModelSerializers::Adapter.create(book_serializer) }

  let(:subject_json) { JSON.parse(subject.to_json) }

  it { expect(subject_json["data"]["attributes"].keys).to contain_exactly("price", "title") }

  it { expect(subject_json["data"]["relationships"].keys).to contain_exactly("author", "publisher") }
end