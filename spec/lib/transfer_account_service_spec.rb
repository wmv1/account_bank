require 'rails_helper'

RSpec.describe TransferAccountService do
  describe ".call" do
    context 'when transfer ok' do
      it "does debit 50 from one and deposit 50 on the other" do
        ximbinha_account_id = 1
        kiko_loureiro_account_id = 2
        ximbinha = create(:user, id: 1, username: 'ximbinha', password: '12345678')
        kiko_loureiro = create(:user, id: 2 ,username: 'kikoloureiro', password: '12345678')
        ximbinha_params  = {  account_id: ximbinha_account_id , account_name: 'Calypso', user_id: ximbinha.id }
        kiko_loureiro_params = { account_id: kiko_loureiro_account_id, account_name: 'Angra', user_id: kiko_loureiro.id }
        ximbinha_account = create(:account, ximbinha_params)
        kiko_loureiro_account =  create(:account, kiko_loureiro_params)

        amount = 50

        described_class.call(ximbinha_account_id, kiko_loureiro_account_id, amount)
        ximbinha_account = Account.find_by(account_id: ximbinha_account_id)
        kiko_account = Account.find_by(account_id: kiko_loureiro_account_id)

        expect(ximbinha_account.balance).to eq(50)
        expect(kiko_account.balance).to eq(150)
      end
    end

    context 'when source account not exists' do
      it "does show alert message" do
        kiko_loureiro_account_id = 2
        kiko_loureiro = create(:user, id: 2 ,username: 'kikoloureiro', password: '12345678')
        kiko_loureiro_params = { account_id: kiko_loureiro_account_id, account_name: 'Angra', user_id: kiko_loureiro.id }
        kiko_loureiro_account =  create(:account, kiko_loureiro_params)

        amount = 50

        expect { described_class.call(1, kiko_loureiro_account_id, amount) }.to raise_error(/Source Account not found/)
      end
    end

    context 'when destination account not exists' do
      it "does show alert message" do
        kiko_loureiro_account_id = 2
        kiko_loureiro = create(:user, id: 2 ,username: 'kikoloureiro', password: '12345678')
        kiko_loureiro_params = { account_id: kiko_loureiro_account_id, account_name: 'Angra', user_id: kiko_loureiro.id }
        kiko_loureiro_account =  create(:account, kiko_loureiro_params)

        amount = 50

        expect { described_class.call(kiko_loureiro_account_id, 1, amount) }.to raise_error(/Destination Account not foun/)
      end
    end

    context 'whe transfer transaction fail' do
      before do
        allow(Account).to receive(:withdraw)
          .with(any_args)
          .and_raise(StandardError, 'Deu ruim')
      end

      it "does nothing happens" do
        ximbinha_account_id = 1
        kiko_loureiro_account_id = 2
        ximbinha = create(:user, id: 1, username: 'ximbinha', password: '12345678')
        kiko_loureiro = create(:user, id: 2 ,username: 'kikoloureiro', password: '12345678')
        ximbinha_params  = {  account_id: ximbinha_account_id , account_name: 'Calypso', user_id: ximbinha.id }
        kiko_loureiro_params = { account_id: kiko_loureiro_account_id, account_name: 'Angra', user_id: kiko_loureiro.id }
        ximbinha_account = create(:account, ximbinha_params)
        kiko_loureiro_account =  create(:account, kiko_loureiro_params)
        amount = 50

        expect { described_class.call(kiko_loureiro_account_id, 1, amount) }
          .to raise_exception(/Deu ruim/)

        ximbinha_account = Account.find_by(account_id: ximbinha_account_id)
        kiko_account = Account.find_by(account_id: kiko_loureiro_account_id)

        expect(ximbinha_account.balance).to eq(100)
        expect(kiko_account.balance).to eq(100)
      end
    end
  end
end