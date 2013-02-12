require 'rspec'
require './app'

describe 'Object#to_oc' do
  describe 'values in hashes' do
    it 'should handle hashes and strings' do
      {"foo" => "bar"}.to_oc.should == %Q|@{
    @"foo": @"bar"
}|
    end

    it 'should handle numbers' do
      {
        "foo" => 12345,
        "bar" => 123.45
      }.to_oc.should == %Q|@{
    @"foo": @12345,
    @"bar": @123.45
}|
    end

    it 'should handle null' do
      {"foo" => nil}.to_oc.should == %Q|@{
    @"foo": [NSNull null]
}|
    end

    it 'should handle dates and urls as strings' do
      {
        "foo" => "2012-12-31 00:05:15",
        "bar" => "http://url.com"
      }.to_oc.should == %Q|@{
    @"foo": @"2012-12-31 00:05:15",
    @"bar": @"http://url.com"
}|
    end

    it 'should handle booleans' do
      {
        "foo" => true,
        "bar" => false
      }.to_oc.should == %Q|@{
    @"foo": @YES,
    @"bar": @NO
}|
    end
  end

  describe 'values in arrays' do
    it 'should handle strings' do
      ["foo", "bar"].to_oc.should == %Q|@[
    @"foo",
    @"bar"
]|
    end

    it 'should handle numbers' do
      [12, 34, 56.78].to_oc.should == %Q|@[
    @12,
    @34,
    @56.78
]|
    end

    it 'should handle null' do
      [nil, nil].to_oc.should == %Q|@[
    [NSNull null],
    [NSNull null]
]|
    end

    it 'should handle dates and urls as strings' do
      [
        "2012-12-31 00:05:15",
        "http://url.com"
      ].to_oc.should == %Q|@[
    @"2012-12-31 00:05:15",
    @"http://url.com"
]|
    end
  end
end

