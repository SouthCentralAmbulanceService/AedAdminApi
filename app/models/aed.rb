# Hold all AED data
class Aed < ActiveRecord::Base
  belongs_to :admin_user
  acts_as_mappable default_units: :miles,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  validates :aed_count, numericality: true
  validates :post_code, presence: true
  validates :latitude, numericality: {
    greater_than_or_equal_to: -90, less_than_or_equal_to: 90
  }
  validates :longitude, numericality: {
    greater_than_or_equal_to: -180, less_than_or_equal_to: 180
  }

  scope :validated, -> { where(validated?: true) }

  def self.geo_search(lat, long, radius)
    Aed.validated.within(radius, origin: [lat, long])
  end
end
