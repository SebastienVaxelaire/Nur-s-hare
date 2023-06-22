class Family < ApplicationRecord
  belongs_to :user
  has_many :children, dependent: :destroy
  validates :user, presence: true
  validates :name, presence: true, on: :update
  validates :description, presence: true, on: :update, length: { minimum: 10, maximum: 1000 }
  validates :address, presence: true, on: :update
  validates :phone_number, presence: true, on: :update
  validate :validate_husband_or_wife_first_name_presence, on: :update
  has_many_attached :photos

  private

  def validate_husband_or_wife_first_name_presence
    if husband_first_name.blank? && wife_first_name.blank?
      errors.add(:base, "Il doit y avoir au moins un papa ou une maman")
    end
  end
end
