require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe RecordTime do

  def new_record(attrs = {})
    # TODO: populate default hash with valid data
    RecordTime.new({}.merge(attrs))
  end

  it "should have a duration" do 
    record_time = new_record(:duration => nil)
    record_time.should_not be_valid
  end

  it "should have a speed" do 
    record_time = new_record(:speed => nil)
    record_time.should_not be_valid
  end
end
