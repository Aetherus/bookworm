require 'rails_helper'

RSpec.describe Librarian, type: :model do
  let(:librarian) { create :librarian }

  it 'has a BCrypt digested password' do
    expect(librarian.password_digest).to start_with('$2a$')
    expect(librarian.authenticate(librarian.password)).to be_truthy
  end

  it 'has a unique email address' do
    expect{create :librarian, email: librarian.email}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
