class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def total_buyers
    customers.count
  end

  def get_market_name
    supermarket.name
  end
end