class Expense < ApplicationRecord
  has_one_attached :csv_file
end