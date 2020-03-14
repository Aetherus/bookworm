require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { create :account }

  it 'has a unique number' do
    expect{create :account, number: account.number}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has a non-negative initial balance' do
    expect{create :account, initial_balance: -1}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
