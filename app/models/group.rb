class Group < ApplicationRecord
  belongs_to :family
  validates :name, presence: true
  validates :description, presence: true
end
