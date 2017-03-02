# Admin User for API/CSV data
class AdminUser < ActiveRecord::Base
  has_many :aeds
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Included for active admin mapping
  def name
    email
  end
end
