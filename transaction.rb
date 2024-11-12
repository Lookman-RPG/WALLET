class Transaction < ApplicationRecord
  belongs_to :wallet

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: %w[deposit withdrawal transfer] }
end
