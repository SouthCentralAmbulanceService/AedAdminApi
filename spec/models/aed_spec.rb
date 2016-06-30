require 'rails_helper'

RSpec.describe Aed, type: :model do
  context 'When validating the model' do
    before(:each) do
      @aed = Aed.new(
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
        phone: '00000000000'
      )
    end

    it 'should create record' do
      expect { @aed.save }.to change { Aed.count }.by(1)
    end

    it 'should destroy record' do
      @aed.save
      expect { @aed.destroy }.to change { Aed.count }.by(-1)
    end

    it 'should should validate entries for record' do
      @aed.aed_count = 'asdads'
      @aed.save
      expect(@aed.errors.full_messages).to eq(['Aed count is not a number'])
    end

    it 'should auto assign false for vaildated?' do
      @aed.save
      expect(@aed.validated?).to eq(false)
    end

    it 'should validate presence of post code' do
      @aed.post_code = nil
      @aed.save
      expect(@aed.errors.full_messages).to eq(["Post code can't be blank"])
    end

    it 'should modify record' do
      @aed.save
      Aed.last.update(validated?: true)
      expect(Aed.last.validated?).to eq(true)
    end

    it 'should provide validated records' do
      @aed.save
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
      expect(Aed.validated.count).to eq(1)
    end

    it 'should validate lat and long entries' do
      @aed.latitude = 'asdads'
      @aed.longitude = 'asdads'
      @aed.save
      expect(@aed.errors.full_messages).to eq(
        [
          'Latitude is not a number',
          'Longitude is not a number'
        ]
      )
    end
  end
end
