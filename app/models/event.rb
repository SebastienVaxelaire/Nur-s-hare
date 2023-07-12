class Event < ApplicationRecord
  belongs_to :group
  has_many :events_families, dependent: :destroy
  has_many :families, through: :events_families

  validates :name, :start_time, :end_time, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }

  default_scope -> { order(:start_time) }

  def time
    "#{I18n.l(start_time, format: '%H:%M')} - #{I18n.l(end_time, format: '%H:%M')}"
  end

  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end
end
