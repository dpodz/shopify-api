class User < ApplicationRecord
  # validations
  validates_presence_of :name, :email, :password_digest
end
