class GradeSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :time_start, :time_end
  has_many :students
end
