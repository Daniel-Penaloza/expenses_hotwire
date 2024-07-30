class MonthlyItem < ApplicationRecord
  has_many :items

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
    items.total_incomes - items.total_outcomes
  end

  def self.accumulated
    MonthlyItem.all.inject(0) { |sum, element| sum + element.msc_by_month }
  end
end