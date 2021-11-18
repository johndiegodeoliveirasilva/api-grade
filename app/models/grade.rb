class Grade < ApplicationRecord
  validates :time_start, presence: true, time_start: true

  has_and_belongs_to_many :students
end
