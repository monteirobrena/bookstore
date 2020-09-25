require 'rails_helper'

RSpec.describe PublishingHouseSerializer, type: :serializer do
  let(:publishing_house)            { PublishingHouse.new }
  let(:publishing_house_serializer) { PublishingHouseSerializer.new(publishing_house) }

  subject { ActiveModelSerializers::Adapter.create(publishing_house_serializer) }

  let(:subject_json) { JSON.parse(subject.to_json) }

  it { expect(subject_json["data"]["attributes"].keys).to contain_exactly("discount", "name") }

  it { expect(subject_json["data"]["relationships"].keys).to contain_exactly("published") }
end