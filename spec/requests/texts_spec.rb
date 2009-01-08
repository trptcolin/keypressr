require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/texts" do
  before(:each) do
    @response = request("/texts")
  end
end