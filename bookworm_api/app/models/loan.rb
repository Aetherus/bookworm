class Loan < ApplicationRecord
  belongs_to :account
  belongs_to :book

  validate :enough_balance, on: :create
  validate :enough_books, on: :create

  # Since the rental fee of a book can change over time,
  # we need a snapshot of the actual fee at the time of the loan.
  before_create :take_fee_snapshot

  scope :concluded, ->{ where.not(concluded_at: nil) }
  scope :unconcluded, ->{ where(concluded_at: nil) }

  def conclude
    update(concluded_at: Time.now)
  end

  private

  def take_fee_snapshot
    self.fee = book.fee
  end

  def enough_balance
    errors.add(:fee, 'Exceeds balance') unless book.fee <= account.balance
  end

  def enough_books
    errors.add(:book_id, 'Unavailable') unless book.available_copies.positive?
  end
end
