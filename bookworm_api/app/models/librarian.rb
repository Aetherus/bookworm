class Librarian < ApplicationRecord
  has_secure_password validations: false

  validates :email, format: { with: /\A[^@]+@[^@]+\z/ }, uniqueness: true
  validates :name, presence: true
end
