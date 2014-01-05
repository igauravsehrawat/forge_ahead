namespace :db  do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Gaurav Sehrawat",
			email: "igauravsehrawat@gmail.com",
			password: "hackpass1$$",
			password_confirmation:"hackpass1$$",
			admin: true)

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
