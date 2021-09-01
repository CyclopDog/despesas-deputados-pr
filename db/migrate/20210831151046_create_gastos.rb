class CreateGastos < ActiveRecord::Migration[6.0]
  def change
    create_table :gastos do |t|
      t.string :nome
      t.datetime :emissao
      t.string :fornecedor
      t.float :valor
      t.string :urldoc
      t.string :uf
    end
  end
end
