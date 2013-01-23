require File.dirname(__FILE__) + '/../spec_helper'

describe Adv::Category do
  it "should be valid" do
    Adv::Category.new.should be_valid
  end
end
