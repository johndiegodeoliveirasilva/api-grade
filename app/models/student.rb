class Student < ApplicationRecord

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :year, presence: true

  has_and_belongs_to_many :grades

  scope :filter_by_name, -> (keyword) { where('lower(name) LIKE ?', "%#{keyword.downcase}%")}
  scope :filter_by_email, -> (keyword) { where('lower(email) LIKE ?', "%#{keyword}%")}
end
