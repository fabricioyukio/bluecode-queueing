class Url < ApplicationRecord
  validates :url, presence: true
  validates :status, presence: true
  # validates :checked_at, presence: true
end
