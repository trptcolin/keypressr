class Language
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  has n, :texts

  before :destroy, :destroy_texts

  def destroy_texts
    self.texts.each{ |t| t.destroy }
  end

end
