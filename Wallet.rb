class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :transactions

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def deposit(amount)
    self.balance += amount
    save!
    transactions.create!(transaction_type: 'deposit', amount: amount)
  end

  def withdraw(amount)
    raise "Insufficient balance" if balance < amount

    self.balance -= amount
    save!
    transactions.create!(transaction_type: 'withdrawal', amount: amount)
  end
end
