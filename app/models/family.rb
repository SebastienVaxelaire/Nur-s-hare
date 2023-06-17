class Family < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :description, presence: true, on: :update
  validates :address, presence: true, on: :update
  validates :phone_number, presence: true, on: :update
  validates :description, presence: true, on: :update, length: { minimum: 10, maximum: 240 }
  validate :validate_husband_or_wife_name_presence, on: :update

  private

  def validate_husband_or_wife_name_presence
    if husband_name.blank? && wife_name.blank?
      errors.add(:base, "Il doit y avoir au moins un papa ou une maman")
    end
  end
end
