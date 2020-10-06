class Author < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :books, dependent: :destroy
  has_many :published, foreign_key: :publisher_id, class_name: 'Book', as: :publisher, dependent: :destroy

  def discount() 10 end
end
