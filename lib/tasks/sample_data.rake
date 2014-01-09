namespace :db  do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Gaurav Sehrawat",
			email: "igauravsehrawat@gmail.com",
			password: "hackpass1$$",
			password_confirmation:"hackpass1$$",
			admin: true)

	def make_users
		admin = User.create!(name: "Gaurav Sehrawat",
							email: "example@igaurav.sehrawat.com",
							password: "stay_hungry",
							password_confirmation: "stay_hungry",
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

	def make_microposts	
			users = User.all(limit: 10)
			50.times do

				content = Faker::Lorem.sentence(5)
				users.each { |user| user.microposts.create!(content: content) }
			end
	end

	def make_relationships
		users = User.all
		user = users.first
		followed_users = users[2..50]
		followers = users[3..40]
		followed_users.each { |followed| user.follow!(followed) }
		followers.each { |follower| follower.follow!(user)}
	end


	
	end
end
