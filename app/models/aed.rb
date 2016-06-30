# Hold all AED data
class Aed < ActiveRecord::Base
  validates :aed_count, numericality: true
  validates :post_code, presence: true
  validates :latitude, numericality: {
    greater_than_or_equal_to: -90, less_than_or_equal_to: 90
  }
  validates :longitude, numericality: {
    greater_than_or_equal_to: -180, less_than_or_equal_to: 180
  }

  scope :validated, -> { where(validated?: true) }
end
