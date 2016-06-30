# Admin User for API/CSV data
class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
end
