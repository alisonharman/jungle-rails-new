require 'rails_helper'

RSpec.describe User, type: :model do
  
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


  describe 'Validations' do
    # validation examples here
  end
end
