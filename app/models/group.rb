class Group < ApplicationRecord
  belongs_to :family
  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :banner_photo
  has_many :families, through: :families_groups
end
