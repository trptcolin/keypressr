require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Language do

  def new_record(attrs = {})
    Language.new({:name => "XHTML"}.merge(attrs))
  end

  it "should have a name" do
    language = new_record(:name => nil)
    language.should_not be_valid
    language.errors[:name].should_not be_nil
  end

end
