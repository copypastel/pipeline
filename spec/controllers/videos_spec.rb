require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Video, "index action" do
  before(:each) do
    dispatch_to(Video, :index)
  end
end