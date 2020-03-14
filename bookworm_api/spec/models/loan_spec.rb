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
    expect(loan3.errors[:fee]).to include('Exceeds balance')
  end

  it 'cannot be created when there is no book available' do
    account = create(:account, initial_balance: 100)
    book = create(:book, fee: 1, quantity: 1)

    loan1 = account.loans.create(book: book)
    expect(loan1.id).to be_present

    loan2 = account.loans.create(book: book)
    expect(loan2.errors[:book_id]).to include('Unavailable')

    loan1.conclude
    loan3 = account.loans.create(book: book)
    expect(loan3.id).to be_present
  end
end
