FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) { |n| "foo#{n}@example.com" }
		f.password "secret"
		f.name "Tester"
		f.secret_code "smart cats"
	end
end
