require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  context 'Basic tests' do
    before(:each) do
      @adminuser = AdminUser.new(
        email: 'testuser@example.com',
        password: 'thisisapassword'
      )
      @aed_args = {
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
      }
    end

    it 'should create admin user' do
      expect { @adminuser.save }.to change { AdminUser.count }.by(1)
    end

    it 'should create a super admin user' do
      @adminuser.super = true
      @adminuser.save
      expect(@adminuser.super).to eq(true)
    end

    it 'should create a default admin user if not super' do
      @adminuser.save
      expect(@adminuser.super).to eq(false)
    end

    it 'should destroy admin user' do
      @adminuser.save
      expect { @adminuser.destroy }.to change { AdminUser.count }.by(-1)
    end

    it 'should should validate entries for admin user' do
      @adminuser.email = nil
      @adminuser.save
      expect(@adminuser.errors.full_messages).to eq(["Email can't be blank"])
    end

    it 'should modify admin user' do
      @adminuser.save
      AdminUser.last.update(email: 'new@example.com')
      expect(AdminUser.last.email).to eq('new@example.com')
    end

    it 'should has_many aeds' do
      @adminuser.save
      aed = @adminuser.aeds.new(@aed_args)
      expect { aed.save }.to change { Aed.count }.by(1)
      expect(@adminuser.aeds.count).to eql(1)
    end
  end
end
