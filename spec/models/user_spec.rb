require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

  
    it 'should save a user when all fields are filled out' do
      @user = User.new({
        first_name: 'Amy',
        last_name: 'Jones',
        email: 'amy@123456.com',
        password: '123456',
        password_confirmation: '123456' 
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
        first_name: 'Amu',
        last_name: 'Jones',
        email: 'amy.123456com',
        password: '123456',
        password_confirmation: 'unique'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password confirmation doesn't match Password")
    end

    it 'should not accept blank email' do
      @user = User.new({
        first_name: 'Amy',
        last_name: 'Jones',
        password: '123456',
        password_confirmation: '123456'
        })
      @user.save
      errors = @user.errors.full_messages
      expect(errors).to include("Email can't be blank")
    end
    
    it 'should have a first_name' do
      @user = User.new({
        last_name: 'White',
        email: 'ww@unique.com',
        password: 'unique',
        password_confirmation: 'unique'
      })
      @user.save          
      errors = @user.errors.full_messages
      expect(errors).to include("First name can't be blank")
    end
    it 'should have a last_name' do
      @user = User.new({
        first_name: 'Walter',
        email: 'walter@qmail.com',
        password: 'ww12345',
        password_confirmation: 'ww12345'
      })
      @user.save          
      errors = @user.errors.full_messages
      expect(errors).to include("Last name can't be blank")
    end
 
    it 'should reject if the password has less than 6' do
      @user = User.new({
        first_name: 'Davy',
        last_name: 'Jones',
        email: 'jones@gmail.com',
        password: 'jones',
        password_confirmation: 'jones'
      })
      save = @user.save
      errors = @user.errors.full_messages

      expect(save).to be false
      expect(errors).to include("Password is too short (minimum is 6 characters)")
    end
 
    it 'should not accept blank email' do
      @user = User.new({
        first_name: 'Davy',
        last_name: 'Jones',
        password: 'jones1234',
        password_confirmation: 'jones1234'        
        })
      @user.save
      errors = @user.errors.full_messages
      expect(errors).to include("Email can't be blank")
    end



  end
end
