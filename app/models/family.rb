class Family < ApplicationRecord
  belongs_to :user
  has_many :children, dependent: :destroy
  has_many :groups, dependent: :destroy
  validates :user, presence: true
  validates :name, presence: true, on: :update
  validates :description, presence: true, on: :update, length: { minimum: 10, maximum: 1000 }
  validates :address, presence: true, on: :update
  validates :phone_number, presence: true, on: :update, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "Le numéro de téléphone n'est pas exact"}
  validate :validate_husband_or_wife_first_name_presence, on: :update
  has_many_attached :photos
  has_many :groups, through: :families_groups

  private

  def validate_husband_or_wife_first_name_presence
    if husband_first_name.blank? && wife_first_name.blank?
      errors.add(:base, "Il doit y avoir au moins un papa ou une maman")
    end
  end
end
