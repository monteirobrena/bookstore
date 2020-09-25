require 'rails_helper'

RSpec.describe AuthorSerializer, type: :serializer do
  let(:author)            { Author.new }
  let(:author_serializer) { AuthorSerializer.new(author) }

  subject { ActiveModelSerializers::Adapter.create(author_serializer) }

  let(:subject_json) { JSON.parse(subject.to_json) }

  it { expect(subject_json["data"]["attributes"].keys).to contain_exactly("discount", "name") }

  it { expect(subject_json["data"]["relationships"].keys).to contain_exactly("books", "published") }
end