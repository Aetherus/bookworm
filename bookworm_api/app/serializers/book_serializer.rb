class BookSerializer < ActiveModel::Serializer
  attributes :id, :isbn, :title, :author, :published_on, :quantity, :fee, :created_at
  # has_many :loans, each_serializer: LoanSerializer, include: [:account]
end
