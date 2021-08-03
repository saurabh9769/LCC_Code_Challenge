class User < ApplicationRecord
  has_secure_password

  enum status: {unarchive: 0, archive: 1}

  # check which user is assigning values
  has_paper_trail

  validates :email,
    presence: true,
    uniqueness: true
end
