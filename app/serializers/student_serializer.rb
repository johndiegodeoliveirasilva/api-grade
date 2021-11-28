class StudentSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :year
  has_many :grades
end
