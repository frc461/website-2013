FactoryGirl.define do
	factory :thread, class: Comment do
		content "This is a test thread"
		title "Tester Thread"
	end
end
