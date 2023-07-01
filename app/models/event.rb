class Event < ApplicationRecord
  belongs_to :group
  has_many :events_families
  has_many :families, through: :events_families

  validates :name, presence: true
  validates :description, presence: true
end
