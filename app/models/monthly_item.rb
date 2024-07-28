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
end