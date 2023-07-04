class Event < ApplicationRecord
  belongs_to :group
  has_many :events_families, dependent: :destroy
  has_many :families, through: :events_families

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
end
