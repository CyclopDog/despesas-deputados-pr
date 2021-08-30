class Expense < ApplicationRecord
  has_one_attached :csv_file

  validates :ano, 
            presence: true,
            format: { with: /\A\d{4}\z/ }, 
            uniqueness: true

  validates :csv_file, 
            attached: true, 
            content_type: "application/csv"
end