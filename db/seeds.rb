# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
def admin_creds
  return default_admin_creds unless ENV['RAILS_ENV'] == 'production'
  {
    email: ENV['ADMIN_USER'],
    password: ENV['ADMIN_PASS']
  }
end

def default_admin_creds
  {
    email: 'admin@example.com',
    password: 'password'
  }
end

def aed_example_values
  [
    {aed_type: 'EXAMPLE 1 GENERAL COMMERCIAL', facility_name: 'EXAMPLE 1 BRACKNELL SPORTS CENTRE', post_code: 'RG189NU'},
    {aed_type: 'EXAMPLE 2 HEALTH CENTER', facility_name: 'EXAMPLE 2 FRIARSGATE PRACTICE', post_code: 'RG170YU'},
    {aed_type: 'EXAMPLE 3 CARE HOME', facility_name: 'EXAMPLE 3 NIGHTINGALE LODGE ROMSEY', post_code: 'PO168UP'}
  ]
end

# Create Admin User
def create_admin
  AdminUser.create!(
    email: admin_creds[:email],
    password: admin_creds[:password],
    password_confirmation: admin_creds[:password]
  )
end

create_admin unless AdminUser.find_by(email: admin_creds[:email])

# Create Example Data
aed_example_values.each_with_index do |data, index|
  Aed.create!(
    aed_type: data[:aed_type],
    facility_name: data[:facility_name],
    address_line_1: rand(100).to_s,
    address_line_2: 'Priors Court Road',
    post_code: data[:post_code],
    ward: 'BERKS',
    aed_count: rand(4),
    aed_location: '1 at Reception 1 at cottages',
    latitude: "51.#{rand(100000..200000).to_s}".to_f,
    longitude: "-1.#{rand(100000..200000).to_s}".to_f,
    phone: '00000000000'
  )
end
