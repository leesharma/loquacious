# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

describe User, type: :model do
  describe 'factory' do
    it 'should be valid' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe 'a valid user' do
    it 'should require an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'should require a unique email (not case-sensitive)' do
      create(:user, email: 'foo@example.com')
      user = build(:user, email: 'Foo@example.com')
      expect(user).not_to be_valid
    end

    it 'should require a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end

    it 'should require a unique username (not case-sensitive)' do
      create(:user, username: 'foobar')
      user = build(:user, username: 'foobar')
      expect(user).not_to be_valid
    end
  end
end
