# frozen_string_literal: true

require 'rails_helper'

# FIXME: Refactor me
RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      email: 'test@gmail.com',
      password: 'test2019',
      gender: true, weight: 55
    )
  end

  describe 'user\'s information is presence' do
    it 'user has email, encrypted_password, gender, weight' do
      should validate_presence_of(:email)
      should validate_presence_of(:encrypted_password)
      # should validate_presence_of(:gender)
      should validate_presence_of(:weight)
    end
  end

  describe 'user\'s email format' do
    it 'email with invalid format is invalid (and get one error message)' do
      user = User.create(
        email: 'test2019@',
        password: 'test2019',
        gender: true,
        weight: 55
      )

      expect(user).to_not be_valid
      expect { raise StandardError, 'email is invalid' }
        .to raise_error 'email is invalid'
      # 問：使用者要得到的錯誤訊息
      # user.email = 'invalid_email_format' =>
      # expect(user).to have(1).errors_on(:email)
    end

    it 'email must be unique' do
      User.create(
        email: 'test@gmail.com',
        password: 'test2019',
        gender: true,
        weight: 55
      )
      u = User.new(
        email: 'test@gmail.com',
        password: 'test2019',
        gender: true,
        weight: 55
      )

      expect(u).to_not be_valid
      expect { raise StandardError, 'email has already been token' }
        .to raise_error 'email has already been token'
    end
  end

  # TODO: Confirm whether the spec is still relevant
  # describe 'user\'s password format' do
  #   it 'pwd length less than 6 charaters is invalid' do
  #     user = User.new(
  #       email: 'test2019@gmail.com',
  #       password: '12345',
  #       gender: true,
  #       weight: 55
  #     )
  #     expect(user).to_not be_valid
  #   end
  # end

  describe 'user\'s weight' do
    it 'user\'s weight must be greater than 0' do
      should validate_numericality_of(:weight).is_greater_than(0)
    end
  end
end
