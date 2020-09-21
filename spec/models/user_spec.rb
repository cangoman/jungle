require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do
    it 'should create a user if all fields are present and valid' do
      @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '1234', password_confirmation: '1234'
      @user.save

      expect(@user.errors.full_messages).to be_empty
    end
   
    describe "password and password confirmation fields" do
      
      it "should not create a user if pw and pw confirmation field do not match" do 
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '1234', password_confirmation: '12345'
        @user.save

        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it 'should create/save a user if password and password_confirmation match' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '1234', password_confirmation: '1234'
        @user.save

        expect(@user.errors.full_messages).to be_empty
        expect(@user.password).to eql(@user.password_confirmation)
      end

      it 'should create/save a user if password field is empty' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: nil, password_confirmation: '1234'
        @user.save

        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'should create/save a user if password_confirmation field is empty' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: 'blah', password_confirmation: nil
        @user.save

        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

    end

    it 'should not create/save a user if email already exists (case sensitive)' do
      @user1 = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '1234', password_confirmation: '1234'
      @user1.save
      @user2 = User.new first_name: 'fname', last_name: 'lname', email: 'TEST@TEST.com', password: '1234', password_confirmation: '1234'

      expect(@user2.save).to be false
    end



  end
end
