require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

  
    it 'should save a user when all fields are filled out' do
      @user = User.new({
        first_name: 'Amy',
        last_name: 'Jones',
        email: 'amy@1234.com',
        password: '1234',
        password_confirmation: '1234' 
      })
      expect(@user.save).to eql(true)
    end

    it 'should reject if the password field is empty' do
      @user = User.new({
        first_name: 'Amy',
        last_name: 'Jones',
        email: 'amy@1234.com',
        password_confirmation: '1234' 
      })
      expect(@user.save).to eql(false)
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end


    it "should reject if the password_confirmation and password don't match" do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'ww@qmail.com',
        password: 'ww0000',
        password_confirmation: '0000'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password confirmation doesn't match Password")
    end
 
  end
end
