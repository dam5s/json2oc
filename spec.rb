require 'rspec'
require './app'

describe 'Object #to_oc' do
  it 'should handle hashes and strings' do
    {"foo" => "bar"}.to_oc.should == %Q|@{
    @"foo": @"bar"
}|
  end

  it 'should handle integers' do
    {"foo" => 12345}.to_oc.should == %Q|@{
    @"foo": @12345
}|
  end

  it 'should handle floats' do
    {"foo" => 123.45}.to_oc.should == %Q|@{
    @"foo": @123.45
}|
  end

  it 'should handle hashes' do
    {"foo" => "bar", "food" => "baz"}.to_oc.should == %Q|@{
    @"foo": @"bar",
    @"food": @"baz"
}|
  end

  it 'should handle arrays' do
    ["foo", "bar", "baz"].to_oc.should == %Q|@[
    @"foo",
    @"bar",
    @"baz"
]|
  end

  it 'should handle null' do
    {"foo" => nil}.to_oc.should == %Q|@{
    @"foo": [NSNull null]
}|
  end

  it 'should handle dates as strings' do
    {"foo" => "2012-12-31 00:05:15"}.to_oc.should == %Q|@{
    @"foo": @"2012-12-31 00:05:15"
}|
  end

  it 'should handle urls as strings' do
    {"foo" => "http://url.com"}.to_oc.should == %Q|@{
    @"foo": @"http://url.com"
}|
  end
end
