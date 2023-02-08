class Auction < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  # validates :reserve_price, presence: true
  # validates :reserve_price, numericality: { greater_than: 0 }
  validates :end_date, comparison: { greater_than: :start_date }

  # belongs_to :user
  # has_many :bids, dependent: :destroy
end
