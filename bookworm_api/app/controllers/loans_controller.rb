class LoansController < ApplicationController
  
  # POST /api/v1/loans
  # 
  # Params
  #   loan[book_id]
  #   loan[account_id]
  #
  def create
    loan = Loan.new(loan_params)
    if loan.save
      render json: loan, serializer: LoanSerializer, include: [:book, :account]
    else
      render json: {errors: loan.errors}, status: 400
    end
  end

  # DELETE /api/v1/loans/:id
  def conclude
    loan = Loan.find(params[:id]).conclude
    render json: loan, serializer: LoanSerializer, include: [:book, :account]
  end

  # GET /api/v1/books/:book_id/loans
  #
  # Params
  #   from: RFC 3339 formated timestamp indicating the beginning of the query period
  #   to:   RFC 3339 formated timestamp indicating the end of the query period
  def index
    loans = Loan.where(book_id: params[:book_id], created_at: params.require(:from)...params.require(:to))
    render json: loans, each_serializer: LoanSerializer, include: []
  end

  private

  def loan_params
    params.require(:loan).permit(:book_id, :account_id)
  end
end
