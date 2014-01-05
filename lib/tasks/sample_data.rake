namespace :db  do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Ankur Saxena",
			email: "flyankur@gmail.com",
			password: "wikimediaintern",
			password_confirmation:"wikimediaintern")

		99.times do |n|
			name = Faker::Name.name
			jotdown = name.split(' ').join
			email = "gaurav#{n+1}@gmail.com"
			password = "easyguess"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end
	end
end
