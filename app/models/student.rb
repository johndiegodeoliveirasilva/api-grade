class Student < ApplicationRecord

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :year, presence: true

  has_and_belongs_to_many :grades
end
