class Loan < ApplicationRecord
  belongs_to :account
  belongs_to :book

  validate :enough_balance, on: :create

  # Since the rental fee of a book can change over time,
  # we need a snapshot of the actual fee at the time of the loan.
  before_create :take_fee_snapshot

  scope :unconcluded, ->{where(returned_at: nil)}

  def conclude
    update(returned_at: Time.now)
  end

  private

  def take_fee_snapshot
    self.fee = book.fee
  end

  def enough_balance
    errors.add(:fee, 'Exceeds balance') unless account.initial_balance > book.fee + account.loans.unconcluded.sum(:fee)
  end
end
