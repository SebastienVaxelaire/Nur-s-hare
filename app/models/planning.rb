class Planning < ApplicationRecord
  belongs_to :group

  validates :start_time, :end_time, :name, presence: true

  default_scope -> { order(:start_time) }

  def time
    "#{I18n.l(start_time, format: '%H:%M')} - #{I18n.l(end_time, format: '%H:%M')}"
    # "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end

  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end
end
