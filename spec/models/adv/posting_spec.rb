require File.dirname(__FILE__) + '/../spec_helper'

describe Adv::Posting do
  it "should be valid" do
    Adv::Posting.new.should be_valid
  end
end
