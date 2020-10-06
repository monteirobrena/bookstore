class PublishingHouse < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :published, as: :publisher, foreign_key: :publisher_id, class_name: 'Book', dependent: :destroy
end
