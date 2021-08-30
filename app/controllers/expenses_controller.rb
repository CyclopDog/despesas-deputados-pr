class ExpensesController < ApplicationController
  before_action :get_expense, only: [:show]
  
  def index
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to @expense
      
    else
      render :new
    end
  end

  private
    def expense_params
      params.require(:expense).permit(:ano, :csv_file)
    end

    def get_expense
      @expense = Expense.find(params[:id])
    end
end