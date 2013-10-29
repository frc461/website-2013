require 'spec_helper'

describe "Forums" do
	describe "NewThread" do
		it "makes a new thread (top-level comment)" do
			forum = FactoryGirl.create(:forum)
			user = FactoryGirl.create(:user)

			# log in
			log_in user

			# create thread
			click_on "Forums"
			click_on forum.name
			click_on "New Thread"
			fill_in "Title", :with => "Thread for testing"
			fill_in "Content", :with => "The test made this thread to see if it worked"
			click_button "Create"

			# checks
			page.should have_content "Created"
			page.should have_content "successfully"
			page.should have_content user.name
			page.should have_content "Thread for testing"
			page.should have_content "The test made this thread to see if it worked"
		end
	end

	describe "NewComment" do
		it "comments on a thread" do
			forum = FactoryGirl.create(:forum)
			user = FactoryGirl.create(:user)
			thread = FactoryGirl.create(:thread, :user_id => user.id, :forum_id => forum.id)

			log_in user
			
			# make a comment
			visit comment_path(thread)
			fill_in "comment_content", :with => "A test comment"
			click_on "Comment"

			# checks
			page.should have_content "A test comment"
			page.should have_content "Created comment"
			page.should have_content "successfully"
		end
	end
end
