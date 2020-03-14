class Book < ApplicationRecord
  has_many :loans

  validates :isbn, presence: true, uniqueness: true
  validates :title, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_copies
    quantity - loans.unconcluded.count
  end
end
