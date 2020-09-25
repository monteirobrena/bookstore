class Book < ApplicationRecord
  validates :title, :price, :author, presence: true

  belongs_to :author
  belongs_to :publisher, polymorphic: true
end
