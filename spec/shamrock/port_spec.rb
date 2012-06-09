require 'spec_helper'

describe Shamrock::Port do
  describe "initialization" do
    it "should set a number" do
      subject.number.should be_a(Integer)
    end
  end
end