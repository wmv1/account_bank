class AccountsController < ApplicationController
   before_action :authenticate!

  def create
    Account.create(account_params)
    render status: :created
  rescue StandardError => e
    unprocessable(e.message)
  end

  def balance
    account = Account.find_by_account_id(params[:account_id])
    return render json: {balance: account.balance}, status: :ok if account
    unprocessable('Account Not Found')
  end

  def transfer
    source_account_id = transfer_params[:source_account_id]
    destination_account_id = transfer_params[:destination_account_id]
    amount = transfer_params[:amount]

    TransferAccountService.call(source_account_id, destination_account_id, amount)

    render json: { transfered: true }
  rescue StandardError => e
    unprocessable(e.message)
  end

  private

  def unprocessable(message)
    render json: { message: message }, status: :unprocessable_entity
  end

  def account_params
    params.require(:account).permit(:account_id, :account_name, :user_id, :balance)
  end

  def amount
    param = params.permit(:amount)
    param[:amount].to_f
  end

  def transfer_params
    params.permit(:source_account_id, :destination_account_id, :amount)
  end
end