require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/languages" do
  before(:each) do
    @response = request("/languages")
  end
end