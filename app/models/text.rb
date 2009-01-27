class Text

  include DataMapper::Resource
  include Paperclip::Resource

  property :id, Serial
  
  belongs_to :language
  has n, :record_times
  
	has_attached_file :attachment
	
  validates_present :language
  validates_attachment_presence :attachment
  validates_with_method :check_line_length

  before :create, :normalize_text

	def check_line_length
    if attachment.to_file.detect{|l| l.length > 80}
      [false, "Code can't have lines longer than 80 characters."]
    else
      true
    end
  end
 
  def normalize_text
    return false if self.attachment.nil?
    File.open(self.attachment.to_file.path, 'r+') do |f|
      out = ""
      f.each do |line|
        out << line.gsub(/\t/, "  ")
      end
      f.pos = 0 
      f.print out
      f.truncate(f.pos)
    end
  end
  
end
