#factories.rb
FactoryGirl.define do
	factory :user do
		sequence(:name) {|n| "Person #{n}" }
		sequence(:email) {|n| "person_#{n}@gmail.com" }
		password "fujitesla"
		password_confirmation "fujitesla"

		factory :admin do
			admin true
		end
	end

	
		factory :micropost do
			content "Lorem ..keep coding dude"
			user
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
