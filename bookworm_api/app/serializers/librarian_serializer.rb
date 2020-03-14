class LibrarianSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :created_at
end
