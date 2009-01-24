require 'dm-timestamps'

class RecordTime
  include DataMapper::Resource
  
  property :id, Serial
  property :duration, Float
  property :speed, Float
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :user
  belongs_to :text

  before :save, :set_speed

  def set_speed
    self.speed = self.text.attachment_file_size / self.duration
  end

  def rounded_duration 
    if self.duration
      "%.02f" % self.duration
    else
      "N/A"
    end
  end

  def rounded_speed
    if self.speed
      "%.02f" % self.speed
    else
      "N/A"
    end
  end

  def user_name
    if self.user
      user.display_name
    else
      "Anonymous"
    end
  end

end
