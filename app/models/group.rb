class Group < ApplicationRecord
  geocoded_by :place_address
  after_validation :geocode, if: :will_save_change_to_place_address?
  belongs_to :family
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  has_one_attached :banner_photo
  has_many :families_groups, dependent: :destroy
  has_many :families, through: :families_groups
  has_many :plannings, dependent: :destroy
  after_create :create_chatroom
  has_one :chatroom, dependent: :destroy
  has_many :events, dependent: :destroy

  private

  def create_chatroom
    Chatroom.create(group: self)
  end
end
