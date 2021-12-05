class GradeSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :time_start, :time_end
  has_many :students

  # use rails cache with a separate name and fiexed expiry
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 12.hours
end
