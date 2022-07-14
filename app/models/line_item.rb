class LineItem < ApplicationRecord
  belongs_to :line_item_date

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_ther: 0 }
  validates :unit_price, presence: true, numericality: { greater_ther: 0 }

  delegate :quote, to: :line_item_date
end
