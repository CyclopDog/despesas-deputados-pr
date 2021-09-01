class Expense < ApplicationRecord
  has_one_attached :csv_file
  has_many :gastos, dependent: :destroy

  ano_inicial = 2000
  ano_final = Date.today.year

  validates :ano, 
            presence: true,
            format: { with: /\A\d{4}\z/ }, 
            uniqueness: true,
            inclusion: { in: ano_inicial..ano_final, message: "- insira um valor entre #{ano_inicial} e #{ano_final}" }

  validates :csv_file, 
            attached: true, 
            content_type: "text/csv"
end