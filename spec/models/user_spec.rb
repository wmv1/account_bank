require 'rails_helper'
include BCrypt

RSpec.describe User, type: :model do
  describe '.attributes' do
    instance = described_class.new
    attributes = %w[id username password created_at updated_at]

    it { expect(instance.attributes.keys).to eq attributes }
  end

  describe '.valid_password?' do
    context 'when password is valid' do
      it 'does return true' do
        user = create(:user, username: 'teste', password: '12345678')
        password = Password.create("12345678")
        expect(user.valid_password?(12345678)).to eq(true)
      end
    end

    context 'when password is invalid' do
      it 'does return false' do
        user = create(:user, username: 'teste', password: '12345678')
        invalid_password = Password.new("$2a$12$fSUSHCNVBk.o2zynhBG2se/E0PHBNq2LyDjF5VHHCdb.smSVQyZds")
        expect(user.valid_password?(invalid_password)).to eq(false)
      end
    end
  end
end