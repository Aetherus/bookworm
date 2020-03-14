class LoanSerializer < ActiveModel::Serializer
  attributes :id, :fee, :created_at, :concluded_at, :book_id, :account_id
  belongs_to :book
  belongs_to :account
end
