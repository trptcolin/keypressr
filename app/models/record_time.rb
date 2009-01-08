class RecordTime
  include DataMapper::Resource
  
  property :id, Serial
  property :duration, Float
  
  belongs_to :user
  belongs_to :text

end
