class StudentSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :year

  
end
