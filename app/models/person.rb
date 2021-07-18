class Person < ApplicationRecord
  validates :first_name, presence: { message: 'First Name is required.' }
  validates :last_name, presence: { message: 'Last Name is required.' }
  validates(:email,
            format: {
              allow_blank: true,
              with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
              message: 'Please enter email in correct format, e.g. xyz@gmail.com'
            })
  validates(:phone,
            format: {
              allow_blank: true,
              with: /\+[0-9]+/,
              message: 'Please enter phone in correct format, e.g. +1100500700'
            })

  # This method will add error_messages
  # in people's objects.
  def error_messages
    errors.messages
  end
end
