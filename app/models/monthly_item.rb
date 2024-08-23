class MonthlyItem < ApplicationRecord
  MONTHLY_LIMIT = 42_000

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
    items.total_incomes_applied - items.total_outcomes_applied
  end

  def month_incomes
    items.applied_charge.total_incomes
  end

  def month_outcomes
    items.applied_charge.total_outcomes
  end

  def chart_by_month
    { incomes: month_incomes, outcomes: month_outcomes } if items.any?
  end

  def self.budget_chart
    current_month = MonthlyItem.find_by(month: Time.now.strftime('%B').downcase)

    if (MONTHLY_LIMIT - current_month.month_outcomes).negative?
      {  budget_overrun: (MONTHLY_LIMIT - current_month.month_outcomes).abs }
    else
      { monthly_limit: MONTHLY_LIMIT, outcomes: MONTHLY_LIMIT - current_month.month_outcomes }
    end
  end

  def self.accumulated
    MonthlyItem.all.inject(0) { |sum, element| sum + element.msc_by_month }
  end

  # TODO: refactor this
  def self.chart_info
    data = [
      ['Month', 'Incomes', 'Outcomes', 'Profit']
    ]

    self.all.each do |m|
      data << [ m.month, m.month_incomes, m.month_outcomes, m.msc_by_month ]
    end

    chart_info = (1..3).map do |i|
      {
        name: data.first[i],
        data: data[1..-1].map { |x| [ x[0], x[i] ] }
      }
    end

    chart_info
  end


end
