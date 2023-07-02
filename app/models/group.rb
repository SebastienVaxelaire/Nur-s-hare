class Group < ApplicationRecord
  geocoded_by :place_address
  after_validation :geocode, if: :will_save_change_to_place_address?
  belongs_to :family
  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :banner_photo
  has_many :families_groups
  has_many :families, through: :families_groups
  has_many :plannings, dependent: :destroy
end
