require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create :book, quantity: 1 }  

  it 'has an unique ISBN number' do
    expect(book.id).to be_present   
    expect{create :book, isbn: ''}.to raise_error(ActiveRecord::RecordInvalid)
    expect{create :book, isbn: book.isbn}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has a title' do          
    expect{create(:book, title: '')}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has a non-negative quantity' do
    book.decrement(:quantity, 2).save
    expect(book.errors[:quantity]).to include('must be greater than or equal to 0')
  end
end
