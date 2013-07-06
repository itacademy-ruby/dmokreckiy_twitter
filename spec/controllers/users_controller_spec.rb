require 'spec_helper'

describe 'UsersController' do

  describe '#sing_in' do
    before do
      visit singin_path
    end

    it "should have content Sing_in text"  do
      page.should have_content 'Sing in'
    end

    it "should have email input" do
    end

    it "should have password input" do
    end

  end  
end