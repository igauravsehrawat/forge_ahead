#factories.rb
FactoryGirl.define do
	factory :user do
		name "Gaurav"
		email "igaurav@gmail.com"
		password "fujitesla"
		password_confirmation "fujitesla"
	end

	factory :user_2 do
		name "Mark Zuckerberg"
		email "mark@facebook.com"
		password "markdragon"
		password_confirmation "markdragon"
	end

	factory :user_3 do
		name "Larry Page"
		email "larry@google.com"
		password "larrycruzer"
		password_confirmation "larrycruzer"
	end

end
