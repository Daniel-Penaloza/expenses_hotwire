class Item < ApplicationRecord
  belongs_to :monthly_item

  validates :name, presence: true
  validates :amount, presence: true

  scope :desc_order, -> { order(created_at: :desc) }
  scope :total_incomes, -> { select(&:income?).sum(&:amount) }
  scope :total_outcomes, -> { select(&:outcome?).sum(&:amount) }
  scope :applied_charge, -> { where(applied: true) }
  scope :total_incomes_applied, -> { applied_charge.total_incomes }
  scope :total_outcomes_applied, -> { applied_charge.total_outcomes }
  scope :current_month, -> (month) { where('monthly_item_id =?', month.id) }

  after_update_commit lambda {
    broadcast_replace_to "totals_list"
  }

  enum item_type: {
    income: 'Income',
    outcome: 'Outcome'
  }

  def income?
    item_type == 'income'
  end

  def outcome?
    item_type == 'outcome'
  end
end
