#factories.rb
FactoryGirl.define do
	factory :user do
		name "Gaurav"
		email "igaurav@gmail.com"
		password "fujitesla"
		password_confirmation "fujitesla"
	end
end
