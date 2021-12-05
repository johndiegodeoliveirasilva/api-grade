class StudentSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :year
  has_many :grades

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 12.hours
end
