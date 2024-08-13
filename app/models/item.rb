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

  after_update_commit -> { broadcast_replace_to "msc", partial: 'items/monthly_saving_capaticy', locals: { item: self.monthly_item.msc_by_month.to_f }, target: 'msc' }
  after_update_commit -> { broadcast_replace_to "month_incomes", partial: 'monthly_items/month_incomes', locals: { monthly_item: self.monthly_item }, target: 'month_incomes' }
  after_update_commit -> { broadcast_replace_to "month_incomes", partial: 'monthly_items/month_outcomes', locals: { monthly_item: self.monthly_item }, target: 'month_outcomes' }
  after_destroy_commit -> { broadcast_replace_to "month_incomes", partial: 'monthly_items/month_incomes', locals: { monthly_item: self.monthly_item }, target: 'month_incomes' }
  after_destroy_commit -> { broadcast_replace_to "month_incomes", partial: 'monthly_items/month_outcomes', locals: { monthly_item: self.monthly_item }, target: 'month_outcomes' }

  after_update_commit -> { broadcast_replace_to "items_chart", partial: 'monthly_items/items_chart', locals: { monthly_item: self.monthly_item }, target: 'items_chart' }
  after_destroy_commit -> { broadcast_replace_to "items_chart", partial: 'monthly_items/items_chart', locals: { monthly_item: self.monthly_item }, target: 'items_chart' }

end
