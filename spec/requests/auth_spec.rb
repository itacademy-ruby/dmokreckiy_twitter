require 'spec_helper'

describe "Auth" do

  describe "Sign in" do
    before do
      visit signin_path
    end

    it "should have signin form" do
      page.should have_selector 'h1', text: "Sign in"
    end

    context "should process authorize" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password

        click_button 'Submit'
      end

      it do
        # debugger
        page.should have_content user.email
      end
    end
  end
end