#AED Admin and API

Admin panel for the input of AED data and API for native client

  - root forwards to http://www.scas.nhs.uk/

##Environment/Build

  - Ruby 2.2.3
  - Rails 4.2.5.1
  - Using [GeoKit](https://github.com/geokit/geokit) in order to validate Lat/Lon with Address fields
  - Clone repo
  - `bundle install`
  - `bundle exec rake db:create`
  - `bundle exec rake db:migrate`
  - `bundle exec rake db:seed`
  - `rails s`

***Note***: Using ENV['CUSTOM_GEO_KEY'] in order to use Mapbox APIs

***Note***: Using [memcachier](https://www.memcachier.com/) in order to use cache on API

Admin creds to be defined in the ENV variables for production:

  - ENV['ADMIN_USER']
  - ENV['ADMIN_PASS']
  - before:
    - `bundle exec rake db:seed`

##Testing

  - `bundle exec rspec`
  - `bundle exec rubocop -R`
  - `bundle exec brakeman`

##Api

  - Request Curl example:

  `curl https://servername/api/aed_data.json`

  - Example format of response

```
{
  "data": [
    {
      "aed_type": "EXAMPLE 1 GENERAL COMMERCIAL",
      "facility_name": "EXAMPLE 1 BRACKNELL SPORTS CENTRE",
      "address_line_1": "48",
      "address_line_2": "Priors Court Road",
      "post_code": "RG189NU",
      "ward": "BERKS",
      "aed_count": 2,
      "aed_location": "1 at Reception 1 at cottages",
      "latitude": "51.199426",
      "longitude": "-1.148588",
      "phone": "00000000000"
    }
  ]
}
```
