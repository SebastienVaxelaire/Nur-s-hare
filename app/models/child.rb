class Child < ApplicationRecord
  belongs_to :family
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  has_many_attached :photos
end
