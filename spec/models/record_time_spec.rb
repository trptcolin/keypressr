require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe RecordTime do

  def new_record(attrs = {})
    RecordTime.new({:duration => 150, :user_id => 1, :text_id => 1}.merge(attrs))
  end

  it "should have a duration" do 
    record_time = new_record(:duration => nil)
    record_time.should_not be_valid
    record_time.errors[:duration].should_not be_nil
  end

  it "should have a speed" do 
    record_time = new_record(:speed => nil)
    record_time.should_not be_valid
    record_time.errors[:speed].should_not be_nil
  end

  it "should have a timestamp" do 
    record_time = new_record(:created_at => nil)
    record_time.should_not be_valid
    record_time.errors[:created_at].should_not be_nil
  end
end
