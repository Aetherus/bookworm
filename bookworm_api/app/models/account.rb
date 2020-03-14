class Account < ApplicationRecord
  has_many :loans

  validates :holder_name, presence: true
  validates :number, uniqueness: true
  validates :initial_balance, numericality: { greater_than_or_equal_to: 0 }

  before_validation :ensure_number, on: :create

  def balance
    self.initial_balance - loans.unconcluded.sum(:fee)
  end

  private

  def ensure_number
    # TODO introduce a reliable method (e.g. Redis)
    # to ensure uniqueness of account numbers without consulting the database.
    # For now, for the purpose of simplicity of the architecture,
    # just use a timestamp.
    self.number ||= Time.now.to_i.to_s
  end
end
