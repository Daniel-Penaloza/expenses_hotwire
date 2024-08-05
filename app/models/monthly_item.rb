class MonthlyItem < ApplicationRecord
  has_many :items, dependent: :destroy

  enum month: {
    january: 'january',
    february: 'february',
    march: 'march',
    april: 'april',
    may: 'may',
    june: 'june',
    july: 'july',
    august: 'august',
    september: 'september',
    october: 'october',
    november: 'november',
    december: 'december'
  }


  def msc_by_month
    items.total_incomes_applied- items.total_outcomes_applied
  end

  def month_incomes
    items.applied_charge.total_incomes
  end

  def month_outcomes
    items.applied_charge.total_outcomes
  end

  def chart_by_month
    { incomes: incomes_chart, outcomes: outcomes_chart } if items.any?
  end

  def incomes_chart
   (MonthlyItem.accumulated / month_incomes) * 100
  end

  def outcomes_chart
    res = (month_outcomes / month_incomes.to_f) * 100
  end

  def self.accumulated
    MonthlyItem.all.inject(0) { |sum, element| sum + element.msc_by_month }
  end
end