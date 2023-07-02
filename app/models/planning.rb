class Planning < ApplicationRecord
  belongs_to :group

  validates :start_time, :end_time, :name, presence: true
end
