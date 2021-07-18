require 'rails_helper'

RSpec.describe Person, type: :model do

  describe 'validations' do
    it 'is not valid without a first_name' do
      person = Person.new(first_name: nil, last_name: "xyz")
      expect(person).to_not be_valid
    end

    it 'is not valid without a last_name' do
      person = Person.new(first_name: 'abc', last_name: nil)
      expect(person).to_not be_valid
    end

    it 'is valid with a valid email' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', email: 'xyz@gmail.com')
      expect(person).to be_valid
    end

    it 'is valid with a invalid email' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', email: 'xyz@gmail')
      expect(person).to_not be_valid
    end

    it 'is valid with a valid phone' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', phone: '+1234567890')
      expect(person).to be_valid
    end

    it 'is valid with a invalid phone' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', phone: '1234567890')
      expect(person).to_not be_valid
    end

    it 'is valid without phone' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', phone: '')
      expect(person).to be_valid
    end

    it 'is valid without email' do
      person = Person.new(first_name: 'abc', last_name: 'xyz', email: '')
      expect(person).to be_valid
    end
  end
end
