class AddExpenseToGasto < ActiveRecord::Migration[6.0]
  def change
    add_reference :gastos, :expense, null: false, foreign_key: true
  end
end
