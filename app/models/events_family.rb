class EventsFamily < ApplicationRecord
  belongs_to :family
  belongs_to :event
end
