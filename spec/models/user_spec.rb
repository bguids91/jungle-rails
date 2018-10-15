require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
  subject { described_class.new(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password") }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without same passwords" do
      subject.password_confirmation = "drowssap"
      expect(subject).to_not be_valid
    end

    it "is not valid without email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without last_name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with password length less than 8" do
      subject.password = "abcdefg"
      expect(subject).to_not be_valid
    end

    it "is valid with password length equal to or greater than 8" do
      subject.password = "abcdefgh"
      subject.password_confirmation = "abcdefgh"
      expect(subject).to be_valid
    end

    it "is not valid without unique email" do
      newUser = User.create(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password")
      newUser2 = User.create(first_name: "Name", last_name: "Name", email: "EMAIL@EMAIL.com", password: "password", password_confirmation: "password")
      expect(newUser2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns a valid user if authenticated" do
      newUser = User.create(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials( newUser.email , 'password' )).to be_a(User)
    end
    it "returns nil if not authenticated" do
      newUser = User.create(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials( newUser.email , 'drowssap')).to be_nil
    end
    it "returns a valid user if authenticated" do
      newUser = User.create(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials( "   email@email.com   " , 'password' )).to be_a(User)
    end
    it "returns a valid user if authenticated" do
      newUser = User.create(first_name: "Name", last_name: "Name", email: "email@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials( "EmAiL@eMaIl.cOm" , 'password' )).to be_a(User)
    end
  end

end
