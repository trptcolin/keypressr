class Language
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  has n, :texts

end
