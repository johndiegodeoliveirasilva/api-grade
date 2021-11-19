class Grade < ApplicationRecord
  validates :title, presence: true
  validates :time_start, presence: true, time_start: true
  validates :time_end, presence: true, time_end: true

  has_and_belongs_to_many :students
end
