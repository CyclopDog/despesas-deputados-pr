class AddAnoECadastroToGastos < ActiveRecord::Migration[6.0]
  def change
    add_column :gastos, :ano, :integer
    add_column :gastos, :cadastro, :string
  end
end
