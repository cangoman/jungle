require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do
    it 'should create a user if all fields are present and valid' do
      @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '12345678', password_confirmation: '12345678'
      @user.save

      expect(@user.errors.full_messages).to be_empty
    end
   
    describe "password and password confirmation fields" do 
      it "should not create a user if pw and pw confirmation field do not match" do 
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '12345678', password_confirmation: '12345'
        @user.save

        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it 'should create/save a user if password and password_confirmation match' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '12345678', password_confirmation: '12345678'
        @user.save

        expect(@user.errors.full_messages).to be_empty
        expect(@user.password).to eql(@user.password_confirmation)
      end

      it 'should create/save a user if password field is empty' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: nil, password_confirmation: '12345678'
        @user.save

        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'should create/save a user if password_confirmation field is empty' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: 'blah', password_confirmation: nil
        @user.save

        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'should throw an error if the password is less than 8 characters long' do
        @user = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '123', password_confirmation: '123'
        @user.save

        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end


    end

    it 'should not create/save a user if email already exists (case insensitive)' do
      @user1 = User.new first_name: 'fname', last_name: 'lname', email: 'test@test.com', password: '12345678', password_confirmation: '12345678'
      @user1.save
      @user2 = User.new first_name: 'fname', last_name: 'lname', email: 'TEST@TEST.com', password: '12345678', password_confirmation: '12345678'

      expect(@user2.save).to be false
      
    end


    it 'should not create/save a user if first name field is empty' do
      @user = User.new first_name: nil, last_name: 'lname', email: 'test@test.com', password: '12345678', password_confirmation: '12345678'
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end


    it 'should not create/save a user if last_name field is empty' do
      @user = User.new first_name: 'fname', last_name: nil, email: 'test@test.com', password: '12345678', password_confirmation: '12345678'
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not create/save a user if email field is empty' do
      @user = User.new first_name: 'fname', last_name: 'lname', email: nil, password: '12345678', password_confirmation: '12345678'
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

  end
end
