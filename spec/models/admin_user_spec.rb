require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  context 'Basic tests' do
    before(:each) do
      @adminuser = AdminUser.new(
        email: 'testuser@example.com',
        password: 'thisisapassword'
      )
    end

    it 'should create admin user' do
      expect { @adminuser.save }.to change { AdminUser.count }.by(1)
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
  end
end
