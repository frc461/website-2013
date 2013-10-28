FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "fooo#{n}@example.com" }
		password "secret"
		name "Tester"
		secret_code SECRET_CODE
	end
end
