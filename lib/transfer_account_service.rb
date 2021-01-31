module TransferAccountService
  def self.call(source_account_id, destination_account_id, amount)

    account = Account.find_by_account_id(source_account_id)
    raise StandardError, 'Source Account not found' unless account

    recipient = Account.find_by_account_id(destination_account_id)
    raise StandardError, 'Destination Account not found' unless recipient

    Account.transfer(account, recipient, amount)
  end
end