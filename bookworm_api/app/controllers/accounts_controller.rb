class AccountsController < ApplicationController

  # POST /api/v1/accounts
  #
  # Params
  #   account[holder_name]
  #   account[initial_balance]
  #
  def create
    render json: Account.create(account_params), serializer: AccountSerializer, include: []
  end

  # GET /api/v1/accounts/:id
  def show
    account = Account.where(params[:id]).preload(:loans => :book).first
    render json: account, serializer: AccountDetailSerializer, include: {:loans => :book}
  end

  private

  def account_params
    params.require(:account).permit(:holder_name, :initial_balance)
  end
end
