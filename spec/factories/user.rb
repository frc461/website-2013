FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) { |n| "foo#{n}@example.com" }
		f.password "secret"
		f.name "Tester"
		f.secret_code SECRET_CODE
	end
end
