require 'spec_helper'

describe "LogIns" do
	it "logs in a user" do
		user = FactoryGirl.create(:user)
		visit log_in_path
		fill_in "Email", :with => user.email
		fill_in "Password", :with => user.password
		click_button "Log in"
		page.should have_content "Logged in!"
		page.should have_content user.name
	end
end
