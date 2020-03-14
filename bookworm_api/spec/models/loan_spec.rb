require 'rails_helper'

RSpec.describe Loan, type: :model do
  it 'cannot be created when the rental fee of the book exceeds the balance' do
    account = create(:account, initial_balance: 100)
    book1 = create(:book, fee: 50)
    book2 = create(:book, fee: 51)

    loan1 = account.loans.create(book: book1)
    expect(loan1.id).to be_present

    loan2 = account.loans.create(book: book2)
    expect(loan2.errors[:fee]).to include('Exceeds balance')

    loan1.conclude
    loan3 = account.loans.create(book: book2)
    expect(loan3.id).to be_present
  end
end
