require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    # Persistent user to compare uneiqueness
  before(:all) do
    @unique_user = User.new({
      first_name: 'Elon',
      last_name: 'Musk',
      email: 'rocketman@telsa.com',
      password: 'rocketman',
      password_confirmation: 'rocketman'
      })
    @unique_user.save
  end
    
  after(:each) do
    @user.destroy
  end

  
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

    it 'should have a unique email address' do
      @user = User.new({
        first_name: 'Walter',
        last_name: 'White',
        email: 'rocketman@telsa.com',
        password: 'ww0000',
        password_confirmation: 'ww0000'
      })
      @user.save          
      errors = @user.errors.full_messages
      expect(errors).to include("Email has already been taken")
    end
    
    
  end

  describe '.authenticate_with_credentials' do
    it 'should login with correct credentials' do
      login_email = 'syd@qmail.com'
      login_password = 'syd123456'

      @user = User.new({
        first_name: 'Syd',
        last_name: 'Smith',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials(login_email, login_password)
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login.id).to eq(database_user_id)
    end

    it 'should reject with incorrect password' do
      login_email = 'syd@qmail.com'
      login_password = 'syd123456'

      @user = User.new({
        first_name: 'Syd',
        last_name: 'Smith',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials(login_email, 'wrong_login_password')
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login).to be false
    end

    it 'should reject with incorrect email' do
      login_email = 'syd@zmail.com'
      login_password = 'syd123456'

      @user = User.new({
        first_name: 'Syd',
        last_name: 'Smith',
        email: login_email,
        password: login_password,
        password_confirmation: login_password
      })
      saved = @user.save     
      login = User.authenticate_with_credentials('login_email@zmail.com', login_password)
      database_user_id = User.find_by(email: login_email).id
      expect(saved).to be true
      expect(login).to be nil
    end
    
    it 'should still login while email address is wrong case' do
      @user = User.new({
        first_name: 'Syd',
        last_name: 'Vicious',
        email: 'sv@qMAIl.com',
        password: 'sv1234',
        password_confirmation: 'sv1234'
      })
        saved = @user.save
        login = User.authenticate_with_credentials('sv@qmail.coM', 'sv1234')
        expect(saved).to be true       
        expect(login.id).to eq(@user.id)
      end

      it "should still login even with surrounding whitespace" do
        @user = User.new({
          first_name: 'Syd',
          last_name: 'Vicious',
          email: 'sv@qmail.com',
          password: 'sv1234',
          password_confirmation: 'sv1234'
        })
          saved = @user.save
          login = User.authenticate_with_credentials('  sv@qmail.coM ', 'sv1234')
          expect(saved).to be true       
          expect(login).to_not be nil
          expect(login.id).to eq(@user.id)
      end

  end

end
