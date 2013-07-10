require 'spec_helper'

describe User do
  it "should raise error if login length <5" do
    expect{ User.create!(:login => "1234") }.to raise_error    
  end 

  context "#password_valid?" do
    let(:user){ FactoryGirl.create(:user, password: 'pass') }

    it "should return true for valid" do
      expect( user.password_valid?('pass') ).to eq true
    end

    it "shoul return false for invalid" do
      expect( user.password_valid?('invealid_pass') ).to eq false
    end

  end
end