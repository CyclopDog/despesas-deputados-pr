Rails.application.routes.draw do
  root to: "expenses#index"
  resources "expenses", path: "/"
end
