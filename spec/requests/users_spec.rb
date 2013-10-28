require 'spec_helper'


describe "LogInUser" do
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

describe "NewUser" do
	it "makes a new user" do
		user = FactoryGirl.build(:user)
		visit new_user_path
		fill_in "Email", :with => user.email
		fill_in "Name", :with => user.name
		fill_in "Secret code", :with => SECRET_CODE
		fill_in "Password", :with => user.password
		fill_in "Password confirmation", :with => user.password
		click_button "Create"
		page.should have_content "Signed up!"
	end
end

describe "UpdateSelf" do
	it "updates the name of a logged in user" do
		user = FactoryGirl.create(:user)

		# log in
		visit log_in_path
		fill_in "Email", :with => user.email
		fill_in "Password", :with => user.password
		click_button "Log in"
		page.should have_content "Logged in!"
		page.should have_content user.name

		# update
		click_link "Account Details"
		fill_in "Name", :with => "Another Tester"
		click_button "Update"

		# checks
		page.should have_content "Another Tester"
	end
end
