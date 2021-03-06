require 'rails_helper'

RSpec.describe Api::AedManagerController, type: :controller do
  context 'Basic API tests' do
    it 'should respond with error if not json request' do
      get :aed_data
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['errors']).to eq(['Not a JSON request'])
    end

    it 'should respond if json request' do
      get :aed_data, format: :json
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['data']).to eq([])
    end

    it 'should not include email in data' do
      expected = {
        aed_type: 'GENERAL COMMERCIAL',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: 51.459982,
        longitude: -1.298559,
        phone: '00000000000'
      }.as_json
      Aed.create!(
        aed_type: 'GENERAL COMMERCIAL',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: '51.459982',
        longitude: '-1.298559',
        phone: '00000000000',
        validated?: true
      )
      get :aed_data, format: :json
      expect(JSON.parse(response.body)['data'].first).to eq(expected)
    end

    it 'should return geo located if lat lng provided within range' do
      Aed.create!(
        aed_type: 'GENERAL COMMERCIAL',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: '51.459982',
        longitude: '-1.298559',
        phone: '00000000000',
        validated?: true
      )
      Aed.create!(
        aed_type: 'GENERAL COMMERCIAL 2',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: '52.459982',
        longitude: '-3.298559',
        phone: '00000000000',
        validated?: true
      )
      query = { lat: 51.459982, lng: -1.298559, radius: 10, format: :json }
      get :aed_data_geo, query
      expect(JSON.parse(response.body)['data'].count).to eq(1)
    end

    it 'should return geo located if lat lng provided bigger range' do
      Aed.create!(
        aed_type: 'GENERAL COMMERCIAL',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: '51.459982',
        longitude: '-1.298559',
        phone: '00000000000',
        validated?: true
      )
      Aed.create!(
        aed_type: 'GENERAL COMMERCIAL 2',
        facility_name: 'PRIORS COURT SCHOOL  HERMITAGE',
        address_line_1: '12',
        address_line_2: 'Priors Court Road',
        post_code: 'RG189NU',
        ward: 'BERKS',
        aed_count: 2,
        aed_location: '1 at Reception 1 at cottages',
        latitude: '52.459982',
        longitude: '-3.298559',
        phone: '00000000000',
        validated?: true
      )
      query = { lat: 51.459982, lng: -1.298559, radius: 200, format: :json }
      get :aed_data_geo, query
      expect(JSON.parse(response.body)['data'].count).to eq(2)
    end
  end
end
