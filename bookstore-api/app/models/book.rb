class Book < ApplicationRecord
  validates :title, :author, presence: true

  belongs_to :author
  belongs_to :publisher, polymorphic: true
end
