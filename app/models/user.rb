class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true

  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  before_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    if User.count == 1
      errors.add(:base, "Can't delete the last user")
      throw(:abort)
    end
  end
end
