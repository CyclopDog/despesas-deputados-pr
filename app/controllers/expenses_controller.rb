class ExpensesController < ApplicationController
  require 'csv'
  USERS = { "demo" => "boitata" }
  before_action :get_expense, only: [:show]
  before_action :authenticate, ony: [:new, :create]
  invisible_captcha only: [:create], honeypot: :jacarecuca

  def index
    @deputados = Gasto.all.group(:nome).order(:nome)
    @expenses = Expense.all.order("ano desc")
    @gastos = Gasto.all.order("valor desc")
  end

  def show
    @gastos = @expense.gastos.group(:nome).sum(:valor)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      @expense.csv_file.open() do |file|
        CSV.open(file, headers: :first_row, encoding: "utf-8", quote_char: "\x00", col_sep: ";").each do |row|

          next if row[5] != '"PR"'

          nome = row[0].gsub('"', '').strip
          emissao = row[16].gsub('"', '').strip
          fornecedor = row[12].gsub('"', '').strip
          valor = row[19].gsub('"', '').strip
          urldoc = row[30].gsub('"', '').strip
          uf = row[5].gsub('"', '').strip
          cadastro = row[2].gsub('"', '').strip
          ano = @expense.ano

          @expense.gastos.create(nome: nome, 
                                 emissao: emissao, 
                                 fornecedor: fornecedor, 
                                 valor: valor, 
                                 urldoc: urldoc, 
                                 uf: uf, 
                                 cadastro: cadastro, 
                                 ano: ano
                                )
        end
      end

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

    def authenticate
      authenticate_or_request_with_http_digest do |username|
        USERS[username]
      end
    end
end