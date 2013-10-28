FactoryGirl.define do
	factory :forum do
		sequence(:name) { |n| "#{n}Forum" }
	end
end
