$stdout.sync = true
# Geo Coder for Lat Long stuff
class GeoCoderDistance
  def initialize
    Geokit::Geocoders::CustomGeocoder.key = ENV['CUSTOM_GEO_KEY']
  end

  def over_max_range?(addr_1, addr_2, post_code, lat, lon)
    return error_response("#{addr_1}, #{addr_2}, #{post_code}") if missing?(
      addr_1, addr_2, post_code, lat, lon
    )
    address_string = create_address(addr_1, addr_2, post_code)
    address_lat_lon = geocoded(address_string)
    lat_lon = [lat, lon].join(', ')
    distance = address_lat_lon.distance_to(lat_lon)
    [distance > 0.1, address_lat_lon.ll]
  rescue
    return error_response(addr_1, addr_2, post_code)
  end

  def obtain_coords(full_address, lat, lon)
    address_lat_lon = geocoded(full_address.to_s)
    lat_lon = [lat, lon].join(', ')
    distance = address_lat_lon.distance_to(lat_lon)
    [distance > 0.1, address_lat_lon.ll]
  rescue
    return error_response(full_address)
  end

  private

  def create_address(addr_1, addr_2, post_code)
    [
      addr_1,
      addr_2,
      post_code
    ].join(', ')
  end

  def geocoded(address_string)
    # Geokit::Geocoders::GoogleGeocoder.geocode(address_string)
    Geokit::Geocoders::CustomGeocoder.geocode(address_string)
  end

  def missing?(addr_1, addr_2, post_code, lat, lon)
    [
      addr_1, addr_2, post_code, lat, lon
    ].any? { |a| a.to_s.empty? }
  end

  def error_response(address)
    default = [true, 'No Lat Lon available']
    address_lat_lon = geocoded(address)
    [true, address_lat_lon.ll]
  rescue
    return default
  end
end
