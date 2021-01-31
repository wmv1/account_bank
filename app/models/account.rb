class Account < ApplicationRecord
  belongs_to :user
  DEFAULT_BALANCE = 100

  validates_presence_of :account_name, :user_id

  def self.create(params)
    params.merge!(account_id: Time.now.to_i) if params[:account_id].nil?
    params.merge!(balance: DEFAULT_BALANCE)  if params[:balance].nil?
    validate_account(params[:account_id], params[:user_id])

    new(params).save!
  end

  def self.transfer(source_account, destination_account, amount)

    message = 'Account with no balance available'
    raise StandardError, message  unless have_balance?(source_account, amount)

    ActiveRecord::Base.transaction do
      self.withdraw(source_account, amount)
      self.deposit(destination_account, amount)
    end
  end

  def self.validate_account(account_id, user_id)
    raise StandardError, 'Account id in use' if find_by_account_id(account_id).present?
    raise StandardError, 'User already has account ' if find_by_user_id(user_id).present?
  end

  private

  def self.find_account_id(account_id)
    Account.find_by_account_id(account_id).id
  end

  def self.find_user_id(user_id)
    Account.find_by_user_id(user_id).id
  end

  def self.amount_valid?(amount)
    if amount <= 0
      return false
    end
    return true
  end

  def self.have_balance?(account, amount)
    account.balance >= amount
  end

  def self.deposit(account, amount)
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance += amount).round(2)
    account.save!
  end

  def self.withdraw(account, amount)
    raise StandardError 'Insufficient funds' unless self.amount_valid?(amount)
    account.balance = (account.balance -= amount).round(2)
    account.save!
  end
end
