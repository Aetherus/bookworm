class AccountSerializer < ActiveModel::Serializer
  attributes :id, :number, :holder_name, :balance, :created_at
  has_many :loans, each_serializer: LoanSerializer, include: [:book]
end
